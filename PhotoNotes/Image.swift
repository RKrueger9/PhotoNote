//
//  Image.swift
//  PhotoNotes
//
//  Created by RKrueger on 2/24/17.
//  Copyright © 2017 rkalvani. All rights reserved.
//

import UIKit

class Image: NSObject, NSCoding
{
    var name : String
    var image : String
    var folder : String
    
    init(name: String , image: String , folder: String)
    {
        self.name = name
        self.image = image
        self.folder = folder
    }
    
    //initilizer is used for loading object of class
    required init?(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
        folder = aDecoder.decodeObject(forKey: "folder") as! String
    }
    
    //used for saving
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name,forKey: "name")
        aCoder.encode(image,forKey: "image")
        aCoder.encode(folder, forKey: "folder")
        
    }


}
