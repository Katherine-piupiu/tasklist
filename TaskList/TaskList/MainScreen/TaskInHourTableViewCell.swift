//
//  TaskInHourTableViewCell.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import UIKit

class TaskInHourTableViewCell: UITableViewCell {

    @IBOutlet weak var taskButton: UIButton!
    var presenter: TaskCellPresenter!
    var task: Task!
        
    @IBAction func onTaskTap(_ sender: Any) {
        self.presenter.openTaskDetail(self.task)
    }
    
    func configure(_ presenter: TaskCellPresenter, task: Task) {
        self.presenter = presenter
        self.task = task
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:MM"
        let start = dateFormater.string(from: task.dateStart)
        let finish = dateFormater.string(from: task.dateFinish)
        let title = String(format: "%@ %@ - %@", task.name, start, finish)
        self.taskButton.setTitle(title, for: .normal)
    }
}
