//
//  TaskPresenter.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import Foundation

class TaskCellPresenter {
    var hourTitleString = ""
    var tasks: [Task]
    var parent: TaskListPresenter
    
    init(_ index: Int, tasks: [Task], parent: TaskListPresenter) {
        self.hourTitleString = String(format: "%02d.00 - %02d.00", index, index + 1)
        self.tasks = tasks
        self.parent = parent
    }
    
    func openTaskDetail(_ task: Task) {
        self.parent.openTaskDetail(task)
    }
}
