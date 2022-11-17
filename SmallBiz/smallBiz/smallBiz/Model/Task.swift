//
//  Task.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/16/22.
//

import Foundation

class Task: Codable {
    let title: String
    let isComplete: Bool
    let id: String
    
    init(title: String, isComplete: Bool = false, id: String = UUID().uuidString){
        self.title = title
        self.isComplete = isComplete
        self.id = id
    }
}

// Equatable
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
