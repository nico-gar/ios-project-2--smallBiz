//
//  EmployeeController.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/15/22.
//

import Foundation

class EmployeeController{
    
//    Shared Instance
    static let shared = EmployeeController()
    
//    Source of Truth
    var employees: [Employee] = []
//    CRUD
    
//    Create
    func addEmployee(firstName: String, lastName:String){
        let newEmployee = Employee(firstName: firstName, lastName: lastName)
        employees.append(newEmployee)
    }
    
//    Delete
    
    
//    MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("SmallBiz.json")
        return fileURL
    }

//    Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(employees)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our songs: \(error) -- \(error.localizedDescription)")
        }
    }

//    Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            employees = try JSONDecoder().decode([Employee].self, from: data)
        } catch {
            print("Error decoding our data into songs: \(error) -- \(error.localizedDescription)")
        }
    }
    
    
}
