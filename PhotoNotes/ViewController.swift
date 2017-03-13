//
//  ViewController.swift
//  PhotoNotes
//
//  Created by rkalvani on 2/21/17.
//  Copyright © 2017 rkalvani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var folderTableView: UITableView!
    
    var folders : [String] = ["Work", "Personal", "Store"]
    var folderName = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    } // array of images inside the folder
    /*
    func keysForValue(value: Value) -> []
    {
        return flatMap
        { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
 */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        
        cell.textLabel?.text = folders[(indexPath as NSIndexPath).row]
        folderName = folders[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(folderName)
         performSegue(withIdentifier: "toCollectionViewSegue", sender: folders[(indexPath as NSIndexPath).row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let index = (folderTableView.indexPathForSelectedRow as NSIndexPath?)?.row
        print(index!)

        folderName = folders[index!]
        let dvc = segue.destination as! CollectionViewController
        //dvc.folderName = folderName
    }


    
    @IBAction func addNewFolderOnTap(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add Folder", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "Add Folder Here"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) -> Void in
            let folderTextField = alert.textFields![0] as UITextField
           self.folders.append(folderTextField.text!)
            self.folderTableView.reloadData()
        }
        alert.addAction(addAction);
        self.present(alert, animated: true, completion: nil);
    }
    
}

