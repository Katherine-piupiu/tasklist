//
//  TaskDetailViewController.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import UIKit

class TaskDetailViewController: UIViewController {
    var task: Task!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.task.name
        self.taskDescriptionLabel.text = self.task.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"

        self.timeLabel.text = String(format: "start: %@ \nend: %@", dateFormatter.string(from: self.task.dateStart), dateFormatter.string(from: self.task.dateFinish))
    }

}
