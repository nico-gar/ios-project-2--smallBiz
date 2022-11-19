//
//  EmployeesListViewController.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/15/22.
//

import UIKit

class EmployeesListViewController: UIViewController {
    // Outlets
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    // Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EmployeeController.shared.loadFromPersistenceStore()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let fullName = textField.text,
              !fullName.isEmpty else { return }
        
        let separatedName = fullName.components(separatedBy: " ")
        guard let firstName = separatedName.first,
              let lastName = separatedName.last
        else { return }
        
        EmployeeController.shared.addEmployee(firstName: firstName, lastName: lastName)
        textField.text = ""
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
}

extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EmployeeController.shared.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let employee = EmployeeController.shared.employees[indexPath.row]
        
        content.text = "\(employee.firstName) \(employee.lastName)"
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete = EmployeeController.shared.employees[indexPath.row]
            
            EmployeeController.shared.delete(employee: employeeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEmployeeTask" {
            // assigning destination to the segue.destination to the screen that I want to go
            guard let destination = segue.destination as? EmployeeTaskListViewController,
                  // indexPath is the cell (row) that was tapped on
                  let indexPath = tableView.indexPathForSelectedRow
                    //bail the function if there is an issue with the destination or indexPath
            else { return }
            // assigning employtoshow to the array of employees
            let employeeToShow = EmployeeController.shared.employees[indexPath.row]
            // this line of code acesses employeeLandingPad variable, which is an employee object and I am setting the value of the varable to be the employee object that was tapped on the tableview
            // creating a window into the employee information
            destination.employeeLandingPad = employeeToShow
        }
    }
}

