//
//  SettingsTableViewCell.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/19/22.
//

import UIKit

protocol SettingChangedProtocol: AnyObject {
    func settingToggled(item: SettingsItem)
}

class SettingsTableViewCell: UITableViewCell{
    
    @IBOutlet var settingsNameLabel: UILabel!
    @IBOutlet var settingsSwitch: UISwitch!
    
    weak var delegate: SettingChangedProtocol?
    
    var item: SettingsItem! {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        settingsNameLabel.text = item.settingTitle
        settingsSwitch.isOn = item.isActive
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        delegate?.settingToggled(item:item)
    }
    
}
