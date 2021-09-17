//
//  Task.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import Foundation

class Task: Decodable {
    let id: String
    let dateStart: Date
    let dateFinish: Date
    let name: String
    let description: String
}
