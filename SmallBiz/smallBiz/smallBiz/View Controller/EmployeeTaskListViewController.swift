//
//  EmployeeTaskListViewController.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/16/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController {
    // similar to source of truth, it grabs on employee from the array of employees of tasks from the task model to reference in EmployeeTaskListView Controller
    var employeeLandingPad: Employee?
    var toaster = "toaster"
    @IBOutlet var addANewTaskList: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let text = addANewTaskList.text, !text.isEmpty else { return }
        
        // This calls our function made in the task controller to append the task and it passes in the employeeLandingPad
        TaskController.assignTaskTo(employeeLandingPad!, taskTitle: text)
        // This removes text from the text field
        addANewTaskList.text = ""
        addANewTaskList.resignFirstResponder()
        // Reloads data
        tableView.reloadData()
    }
}

extension EmployeeTaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = employeeLandingPad!.tasks[indexPath.row]
            TaskController.deleteTaskFrom(employeeLandingPad!, taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //count is assigned to the count in tasks, it reads as: grab employee, if its there, grab its tasks and count them. employee has an optional, becuase what if there wasn't an employee, if thats the case then the count is 0
        let count = employeeLandingPad?.tasks.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // I am assigning "cell" to the location where the task will be placed (tableViewCell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        // "content" is being assigned to cell, whatever is written in the tableViewCell will be assigned the variable content.
        var content = cell.defaultContentConfiguration()
        // task is being assigned to the array tasks that is located in the Task model.. if its there, hence the ?
        let task = employeeLandingPad?.tasks[indexPath.row]
        //content.text is assigned to what was placed in the field. it reads as grab task, if its there, then grab the title of the task. if it isn't there mark with a "-"
        content.text = task?.title ?? "-"
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    

    

    
}
