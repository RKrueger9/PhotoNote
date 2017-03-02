//
//  CollectionViewController.swift
//  PhotoNotes
//
//  Created by RKrueger on 2/22/17.
//  Copyright © 2017 rkalvani. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var images = [Image]()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ImageViewControllerCell
        let image = images[indexPath.item]
        cell.CollectionCellLabel.text! = image.name
        let path = getDocumentDirectory().appendingPathComponent(image.image)
        cell.collectionCellImageView.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let image = images[indexPath.row]
        
        let ac = UIAlertController(title: "Add Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            image.name = newName.text!
            
            self.imageCollectionView?.reloadData()
            //self.save()
            
        })
        present(ac, animated: true)
    }
    
    func addNewImage()              // Func to add new image easily
    {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getDocumentDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80)
        {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Image(name: "Unknown", image: imageName)
        images.append(picture)
        imageCollectionView?.reloadData()
        //save()
        
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageCellOnTap(_ sender: UIBarButtonItem)
    {
        //creates 2 options for user to add image with Camera or Library
        let ac = UIAlertController(title: "Camera or Library", message: nil, preferredStyle: .alert)
        
        //library Action
        let libraryAction = UIAlertAction(title: "Library", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.addNewImage()
        }
        
        //camera action
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            print("chosen camera")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                
                
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                self.imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        ac.addAction(cameraAction)
        ac.addAction(libraryAction)
        self.present(ac, animated: true)
    }

}
    



