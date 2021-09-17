//
//  TaskListService.swift
//  TaskList
//
//  Created by Catherine Kashtanova on 18.09.2021.
//

import Foundation

class TaskListService {
    
    func loadTasks() -> [Task] {
        let jsonData = readLocalJSONFile(forName: "tasks")
        if let data = jsonData {
            return self.parse(jsonData: data)
        }
        return [Task]()
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [Task] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            let decodedData = try decoder.decode([Task].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return [Task]()
    }
}
