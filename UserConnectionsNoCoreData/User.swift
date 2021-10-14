//
//  User.swift
//  UserConnectionsNoCoreData
//
//  Created by Jake King on 23/08/2021.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: Array<String>
    
    struct Friend: Codable, Identifiable {
        var id: UUID
        var name: String
    }
    
    let friends: Array<Friend>
}
