//
//  ItemsManager.swift
//  Scavenger Hunt :)
//
//  Created by Apple on 3/26/16.
//  Copyright © 2016 Robin x Apple. All rights reserved.
//

import Foundation

class ItemsManager {
    var itemsList = [ScavengerHuntItem]()

    func archivePath() -> String? { /* -> = return string; ? = optional string */
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentsPath = directoryList.first {
            return documentsPath + "/ScavengerHuntItems"
        }
        assertionFailure("Could not determine wehre to store the file/")
        return nil /* archive path method returns optional string --> gets list of directories where can possible store things take first thing out of list, append file, make error case -- assertion failer; return nil documents */
    }
    
    func save() {
        if let theArchivePath = archivePath(){ /*if that does work, go head and save it*/
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath) {
                print("Saved successfully.")
            } else {
                assertionFailure("Could not save data to \(theArchivePath)")
            }
            
        }
    }
    
    init() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath){
                itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
}