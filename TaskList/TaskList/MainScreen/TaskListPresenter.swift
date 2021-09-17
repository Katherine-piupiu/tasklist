//
//  TaskListPresenter.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import Foundation

class TaskListPresenter {
    let hoursCount = 24
    var cellPresenters = [TaskCellPresenter]()
    var view: TaskListViewInput
    let service = TaskListService()
    
    init(_ view: TaskListViewInput) {
        self.view = view
    }
    
    func loadTableForDate(_ date: Date) {
        let allTasks = service.loadTasks().filter { task in
            return self.isSameDay(task.dateStart, date: date) || self.isSameDay(task.dateFinish, date: date)
        }
        self.cellPresenters = [TaskCellPresenter]()
        for i in 0...self.hoursCount - 1 {
            let leftHourDateBounds = self.boundsDate(date, hour: i)
            let rightHourDateBounds = self.boundsDate(date, hour: i + 1)
            
            let tasks = allTasks.filter { task in
                return self.isTaskInHour(task, leftBounds: leftHourDateBounds, rightBounds: rightHourDateBounds)
            }
                
            let presenter = TaskCellPresenter(i, tasks: tasks, parent: self)
            cellPresenters.append(presenter)
        }
    }
    
    func isTaskInHour(_ task: Task, leftBounds: Date , rightBounds: Date) -> Bool {
        let start = task.dateStart
        let finish = task.dateFinish
        let leftCondition = leftBounds < start && rightBounds > start
        let middleCondition = rightBounds > start && rightBounds < finish
        let rightCondition = finish < rightBounds && leftBounds < finish
        return leftCondition || middleCondition || rightCondition
    }
    
    func boundsDate(_ date:Date, hour: Int) -> Date {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var components = gregorian.components([.year, .month, .day, .hour, .minute, .second], from: date as Date)

        components.hour = hour
        components.minute = 0
        components.second = 0

        return gregorian.date(from: components)!
    }
    
    func isSameDay(_ date1: Date, date: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    func cellPresenter(_ index: Int) -> TaskCellPresenter {
        return self.cellPresenters[index]
    }
    
    func openTaskDetail(_ task: Task) {
        self.view.openTaskDetail(task)
    }
}
