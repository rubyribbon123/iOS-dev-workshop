//
//  ListViewController.swift
//  Scavenger Hunt :)
//
//  Created by Apple on 3/26/16.
//  Copyright © 2016 Robin x Apple. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate /*not actually using the last two, but Xcode will yell at us if we don't, so here it is */ {
    var myManager = ItemsManager()
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.itemsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        let item = myManager.itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        
        if (item.completed) {
            cell.imageView?.image = item.photo
            cell.accessoryType = .Checkmark /*if the item was completed, we configure wit hthe image and the checkmark; otherwise , make sure that the cell's imageview image is set to nil --> clears any previously set item in there; clears check box */
        } else {
            cell.imageView?.image = nil
            cell.accessoryType = .None /*wants it to be nothing; basic type have accessories in table view cells*/
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil) /*present this imagepicker */
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            selectedItem.photo = photo
            myManager.save()
            
            dismissViewControllerAnimated(true, completion: { () -> Void in /*block of code we will execute, by clicking on blue rectangle and hitting "return"  below, askng table viewer to reload rows*/
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
    @IBAction func unwindToList (segue: UIStoryboardSegue){ //add "meat" of unwindtolist segue
        /*"tell me who the source view controller is bc need something from it" // != we know completely that that is what it is. */
        let addVC = segue.sourceViewController as! AddViewController
        
        if let newItem = addVC.newItem {  /*asking for new item */
            myManager.itemsList += [newItem]
            myManager.save() /*do this every time because on an iPhone, it can run out of juice, prevents you from losing everything that you did. goes ahead and saves it right away */
            let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
}