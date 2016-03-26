//
//  ScavengerHuntItem.swift
//  Scavenger Hunt :)
//
//  Created by Apple on 3/26/16.
//  Copyright © 2016 Robin x Apple. All rights reserved.
//

import UIKit

class ScavengerHuntItem : NSObject, NSCoding{
    let name: String
    var photo: UIImage?
    var completed : Bool {
        return photo != nil
    }
    
    let nameKey = "name"
    let photoKey = "photo"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
        
    }
    required init?(coder aDecoder: NSCoder) { /*if you subclass it, you must make initializer with required keyword, safety thing in swift */
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }


    init(name : String) {
        self.name = name
    }
}
