//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 17.09.2021.
//

import UIKit

protocol TaskListViewInput {
    func openTaskDetail(_ task: Task)
}

class TaskListViewController: UIViewController, TaskListViewInput {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    let cellId = "TaskTableViewCell"
    var presenter: TaskListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = TaskListPresenter(self)
        self.taskTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.taskTableView.delegate = self
        self.taskTableView.dataSource = self
        self.presenter.loadTableForDate(self.datePicker.date)
    }
    
    @IBAction func datePickerValueChaned(_ sender: Any) {
        self.presenter.loadTableForDate(self.datePicker.date)
        self.taskTableView.reloadData()
    }
    
    func openTaskDetail(_ task: Task) {
        guard let taskDetailViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TaskDetailViewController") as? TaskDetailViewController else {
                fatalError("Unable to Instantiate Quotes View Controller")
            }
        taskDetailViewController.task = task
        self.navigationController?.pushViewController(taskDetailViewController, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.hoursCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.taskTableView.dequeueReusableCell(withIdentifier:
                                                                        self.cellId, for: indexPath)
        if let taskCell = cell as? TaskTableViewCell {
            let index = indexPath.row
            let cellPresenter = self.presenter.cellPresenter(index)
            taskCell.configure(cellPresenter)
        }

        return cell
    }
}
