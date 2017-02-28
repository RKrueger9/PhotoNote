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
    
    var folders = ["0", "1", "2", "3", "4", "5", "6", "7"]         //changing later, int just for testing
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = folders[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "toCollectionViewSegue", sender: folders[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
}

