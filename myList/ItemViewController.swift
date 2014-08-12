//
//  ItemViewController.swift
//  myList
//
//  Created by Tomas Vega on 8/11/14.
//  Copyright (c) 2014 Tomas Vega. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textFieldItem: UITextField!
    @IBOutlet var textFieldQuantity: UITextField!
    @IBOutlet var textFieldInfo: UITextField!
    
    var item: String?
    var quantity: String?
    var info: String?
    
    var existingItem: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if existingItem {
            textFieldItem.text = item
            textFieldQuantity.text = quantity
            textFieldInfo.text = info
        }
        //This makes it so that textFieldShouldReturn works and the keyboard hides when the user clicks return
        textFieldItem.delegate = self
        textFieldQuantity.delegate = self
        textFieldInfo.delegate = self

    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        //Reference to our app delegate
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        //Reference NSManaged object context
        
        let context: NSManagedObjectContext = appDel.managedObjectContext! //I unwrapped but tutorial didn't say that
        let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        
        //Check if item exists
        
        if existingItem {
            existingItem.setValue(textFieldItem.text as String, forKey: "item")
            existingItem.setValue(textFieldQuantity.text as String, forKey: "quantity")
            existingItem.setValue(textFieldInfo.text as String, forKey: "info")
        } else {
            //Create instance of our data model and initialize
            var newItem = Model(entity: entity, insertIntoManagedObjectContext: context)
            
            //Map our properties
            newItem.item = textFieldItem.text
            newItem.quantity = textFieldQuantity.text
            newItem.info = textFieldInfo.text
        }
        
        //Save our context
        context.save(nil)

        //navigate back to root vc
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.navigationController.popToRootViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //iOS Touch Functions
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }
    
    //UITextField Delegate
    //Hide keyboard when click return
    //Not working before, fixed it by setting delegates to self in viewDidLoad
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
}
