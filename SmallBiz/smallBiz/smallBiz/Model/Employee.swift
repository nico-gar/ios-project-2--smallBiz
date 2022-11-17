//
//  Employee.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/15/22.
//

import Foundation

class Employee: Codable {
    var firstName: String
    var lastName: String
    var tasks: [Task]
    var skillLevel: Int
    let id: String
    init(firstName: String, lastName: String, tasks: [Task] = [], skillLevel: Int = 0, id: String = UUID().uuidString) {
        self.firstName = firstName
        self.lastName = lastName
        self.tasks = tasks
        self.skillLevel = skillLevel
        self.id = id
    }
}

// Equatable
extension Employee: Equatable {
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
}
