//
//  meal.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/25.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        guard !name.isEmpty else{
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name=name
        self.photo=photo
        self.rating=rating
    }
}
