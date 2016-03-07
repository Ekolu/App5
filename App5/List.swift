//
//  List.swift
//  App5
//
//  Created by Kipras on 3/6/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

// Creates a class for List, which has a name, an image and an array of elements.
class List {
    
    var listName: String
    var listImage: UIImage?
    var listArray = [String]()
    
    init?(name: String, image: UIImage?, array: [String]) {
        // Initialize stored properties.
        self.listName = name
        self.listImage = image
        self.listArray = array
    }
    
}