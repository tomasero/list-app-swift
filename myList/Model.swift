//
//  Model.swift
//  myList
//
//  Created by Tomas Vega on 8/11/14.
//  Copyright (c) 2014 Tomas Vega. All rights reserved.
//

import UIKit
import CoreData

//make class available to obj-c : optional
@objc(Model)
class Model: NSManagedObject {
   
    //properties feeding the attributes in our entity must match the entity attributes
    @NSManaged var item: String
    @NSManaged var quantity: String
    @NSManaged var info: String
    
}
