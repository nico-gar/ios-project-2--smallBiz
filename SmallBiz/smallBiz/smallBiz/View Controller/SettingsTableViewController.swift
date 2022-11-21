//
//  SettingsTableViewController.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/19/22.
//

import UIKit

class SettingsTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    // ended here project 2 part 3 number 2
    lazy var datasource: [SettingsItem] = {
        return [SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch)]
    }()
    
    
    
}


struct SettingsItem {
    var settingTitle: String
    var isActive: Bool
    var type: SettingCellType
}

enum SettingCellType{
    case toggleSwitch
    case disclosure
}
