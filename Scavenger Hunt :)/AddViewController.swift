//
//  AddViewController.swift
//  Scavenger Hunt :)
//
//  Created by Apple on 3/26/16.
//  Copyright © 2016 Robin x Apple. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var newItem: ScavengerHuntItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text { //*gives us contents of text field
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }

}

