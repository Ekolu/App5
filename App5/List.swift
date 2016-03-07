//
//  List.swift
//  App5
//
//  Created by Kipras on 3/6/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class List {
    
    var listName: String
    var listImage: UIImage?
    var listArray = [String]()
    
    // MARK: Initialization
    
    init?(name: String, image: UIImage?, array: [String]) {
        // Initialize stored properties.
        self.listName = name
        self.listImage = image
        self.listArray = array
        
        // Initialization should fail if there is no name or if the rating is negative.
        if listName.isEmpty {
            return nil
        }
    }
    
}