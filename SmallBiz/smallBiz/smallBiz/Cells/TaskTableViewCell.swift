//
//  TaskTableViewCell.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 11/19/22.
//

import UIKit

struct CellImages {
    static let incomplete: UIImage = UIImage(systemName: "circle")!
    static let complete: UIImage = UIImage(systemName: "circle.inset.filled")!
}

protocol TaskStatusChangedProtocol: AnyObject {
    func updateTaskStatus(task: Task)
}

class TaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    
    weak var delegate: TaskStatusChangedProtocol?
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        if let task = task {
            delegate?.updateTaskStatus(task: task)
        }
    }
    
    func updateViews() {
        if let task = task {
            taskTitleLabel.text = task.title
            taskButton.setImage(task.isComplete ? CellImages.complete : CellImages.incomplete, for: .normal)
        }
    }
}
