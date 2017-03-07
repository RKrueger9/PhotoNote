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
    
    init(name: String , image: String)
    {
        self.name = name
        self.image = image
    }
    
    //initilizer is used for loading object of class
    required init?(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    //used for saving
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name,forKey: "name")
        aCoder.encode(image,forKey: "image")
        
    }


}
