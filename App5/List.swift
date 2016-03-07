//
//  List.swift
//  App5
//
//  Created by Kipras on 3/6/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

// Creates a class for List, which has a name, an image and an array of elements.
class List: NSObject, NSCoding {
    
    // Properties
    var listName: String
    var listImage: UIImage?
    var listArray = [String]()
    
    // Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lists")
    
    // Types
    struct PropertyKey {
        static let nameKey = "name"
        static let imageKey = "image"
        static let arrayKey = "array"
    }
    
    // Initialization
    init?(name: String, image: UIImage?, array: [String]) {
        // Initialize stored properties.
        self.listName = name
        self.listImage = image
        self.listArray = array
        super.init()
        
        if name.isEmpty {
            return nil
        }
    }
    
    // NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(listName, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(listImage, forKey: PropertyKey.imageKey)
        aCoder.encodeObject(listArray, forKey: PropertyKey.arrayKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        // Because photo is an optional property of Meal, use conditional cast.
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        let array = aDecoder.decodeObjectForKey(PropertyKey.arrayKey) as! [String]
        // Must call designated initilizer.
        self.init(name: name, image: image, array: array)
    }
    
}