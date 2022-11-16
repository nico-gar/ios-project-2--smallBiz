//
//  Employee.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/15/22.
//

import Foundation

class Employee: Codable {
    let firstName: String
    let lastName: String
    let skillLevel: Int
    let id: String
    init(firstName: String, lastName: String, skillLevel: Int = 0, id: String = UUID().uuidString) {
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.id = id
    }
    
    // Equatable
    
}
extension Employee: Equatable {
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
}
