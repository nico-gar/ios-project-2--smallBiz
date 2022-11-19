//
//  TaskController.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/16/22.
//

import Foundation

class TaskController {

    static func assignTaskTo(_ employee: Employee, taskTitle: String){
        
        let newTask = Task(title: taskTitle)
        
        employee.tasks.append(newTask) 
        
        EmployeeController.shared.saveToPersistenceStore()
    }
    
    static func toggleTaskStatus(employee: Employee, task: Task){
        guard let taskIndex = employee.tasks.firstIndex(of: task),
              let employeeIndex = EmployeeController.shared.employees.firstIndex(of: employee)
        else {
            return
        }
        
        EmployeeController.shared.employees[employeeIndex].tasks[taskIndex].isComplete.toggle()
        
        EmployeeController.shared.saveToPersistenceStore()
    }

    static func deleteTaskFrom(_ employee: Employee, _ task: Task) {
            // Locate the index of the task we are attempting to remove
            guard let index = employee.tasks.firstIndex(of: task) else { return }

            // Remove task from employee
            employee.tasks.remove(at: index)
            print("Successfully removed task from \(employee.firstName)'s list of tasks.")

            // Use the Employee Controller to save changes
            EmployeeController.shared.saveToPersistenceStore()
        }
}
