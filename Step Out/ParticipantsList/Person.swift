//
//  PersonSession.swift
//  Step Out
//
//  Created by Mac on 8/21/20.
//  Copyright © 2020 Bexultan. All rights reserved.
//

import Foundation

class Person {
    let name: String
    let surname: String
    let steps: Int
    let rating: Int
   
    init (name: String, surname: String, steps: Int, rating: Int) {
        self.name = name
        self.surname = surname
        self.steps = steps
        self.rating = rating
    }
    
}
