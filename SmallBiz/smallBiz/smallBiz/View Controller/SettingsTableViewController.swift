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
    
    lazy var datasource: [SettingsItem] = {
        var item = SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch)
        item.readDefaults()
        var secondItem = SettingsItem(settingTitle: "Default Items", isActive: false, type: .disclosure)
        return [item, secondItem]
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // taking the count from the datasource, this will set the number of rows to however many items we have
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.row]
        
        switch item.type {
        case .toggleSwitch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
            cell.item = item
            cell.delegate = self
            return cell
            
        case .disclosure:
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: "disclosureCell", for: indexPath) as?
                    DisclosureTableViewCell else { return UITableViewCell() }
            cell.disclosureCellLabel.text = item.settingTitle
            return cell
        }
    }
}

extension SettingsTableViewController: SettingChangedProtocol {
    func settingToggled(item: SettingsItem) {
        UserDefaults.standard.set(!item.isActive, forKey: item.settingTitle)
    }
}

struct SettingsItem {
    var settingTitle: String
    var isActive: Bool
    var type: SettingCellType
    
    mutating func readDefaults() {
        let defaults = UserDefaults.standard
        self.isActive = defaults.bool(forKey: self.settingTitle)
    }
}

enum SettingCellType{
    case toggleSwitch
    case disclosure
}
