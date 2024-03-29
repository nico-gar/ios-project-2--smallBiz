//
//  EmployeeTaskListViewController.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/16/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController {
    // similar to source of truth, it grabs on employee from the array of employees of tasks from the task model to reference in EmployeeTaskListView Controller
    var employee: Employee?
    
    // MARK - Outlets Start
    @IBOutlet var addANewTaskList: UITextField!
    @IBOutlet var tableView: UITableView!
    
    // MARK - Outlets End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViewTitle() {
        self.navigationItem.title = "\(employee!.firstName)'s Tasks"
    }
    
    // MARK - Action Outlets Start
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let text = addANewTaskList.text,
                !text.isEmpty
        else { return }
        // This calls our function made in the task controller to append the task and it passes in the employee
        TaskController.assignTaskTo(employee!, taskTitle: text)
        // This removes text from the text field
        addANewTaskList.text = ""
        addANewTaskList.resignFirstResponder()
        // Reloads data
        tableView.reloadData()
    }
    // MARK - Action Outlets End
}

extension EmployeeTaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = employee!.tasks[indexPath.row]
            TaskController.deleteTaskFrom(employee!, taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //count is assigned to the count in tasks, it reads as: grab employee, if its there, grab its tasks and count them. employee has an optional, becuase what if there wasn't an employee, if thats the case then the count is 0
        let count = employee?.tasks.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // I am assigning "cell" to the location where the task will be placed (tableViewCell)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell
        else {
            return UITableViewCell()
        }
        let task = employee?.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}

extension EmployeeTaskListViewController: TaskStatusChangedProtocol {
    func updateTaskStatus(task: Task) {
        TaskController.toggleTaskStatus(employee: employee!, task: task)
        tableView.reloadData()
    }
}
