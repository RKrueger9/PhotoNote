//
//  Image.swift
//  PhotoNotes
//
//  Created by RKrueger on 2/24/17.
//  Copyright © 2017 rkalvani. All rights reserved.
//

import UIKit

class Image: NSObject
{
    var name : String
    var image : String
    
    init(name: String , image: String)
    {
        self.name = name
        self.image = image
    }

}
