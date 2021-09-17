//
//  TaskTableViewCell.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var hourIntervalLabel: UILabel!
    var presenter: TaskCellPresenter!
    let cellId = "TaskInHourTableViewCell"
    let defaultCellHeight = CGFloat(26.0)
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.taskListTableView.dataSource = self
        self.taskListTableView.delegate = self
        self.taskListTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }

    func configure(_ presenter: TaskCellPresenter) {
        self.presenter = presenter
        self.hourIntervalLabel.text = self.presenter.hourTitleString
        self.taskListTableView.isHidden = self.presenter.tasks.count == 0
        if (self.taskListTableView.isHidden) {
            self.tableHeightConstraint.constant = self.defaultCellHeight
        } else {
            self.taskListTableView.reloadData()
            self.tableHeightConstraint.constant = self.taskListTableView.contentSize.height
        }
    }
}
extension TaskTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.taskListTableView.dequeueReusableCell(withIdentifier:
                                                                        self.cellId, for: indexPath)
        if let taskInHourCell = cell as? TaskInHourTableViewCell {
            let index = indexPath.row
            let task = self.presenter.tasks[index]
            taskInHourCell.configure(presenter, task: task)
        }

        return cell
    }
}
