//
//  SessionsStorage.swift
//  Step Out
//
//  Created by Mac on 8/21/20.
//  Copyright © 2020 Bexultan. All rights reserved.
//

import Foundation

class SessionsStorage {
   // static let shared = SessionsStorage()
    var sessions = [Person]()

    func add (_ session: Person) {
        sessions.append(session)
    }
}

//
//    let bex = Person(name: "Bexultan", surname: "Tokan", steps: 2002, rating: 1)
//    let abylay = Person(name: "Abylay", surname: "Yerzhanov", steps: 2001, rating: 2)
//    let aidar = Person(name: "Aidar", surname: "Nugmanoff", steps: 2000, rating: 3)
//    let dara = Person(name: "Dara", surname: "Tumenbayeva", steps: 1999, rating: 4)

