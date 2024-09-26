//
//  DataAddFile.swift
//  To Do List
//
//  Created by R95 on 05/09/24.
//

import UIKit
import CoreData

struct TaskData {
    var taskNmae: String?
    var prioritylevel: String?
    var date: Date?
}

var addTaskObj  = Addtask()
var dataArray: [TaskData] = [TaskData]()

class Addtask {
    
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
    
    func addData(taskname: String,prioritylevel: String,date: Date) {
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context!)
        let newData = NSManagedObject(entity: entity!, insertInto: context)
        newData.setValue(taskname, forKey: "taskname")
        newData.setValue(prioritylevel, forKey: "prioritylevel")
        newData.setValue(date, forKey: "date")
        saveData()
    }
    
    private func saveData() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getData() {
        do {
            if let result = try context?.fetch(fetchData) as? [NSManagedObject] {
                for data in result {
                    let taskname = data.value(forKey: "taskname") as? String ?? ""
                    let prioritylevel = data.value(forKey: "prioritylevel") as? String ?? ""
                    let date = data.value(forKey: "date") as? Date
                    let data = TaskData(taskNmae: taskname, prioritylevel: prioritylevel, date: date)
                    dataArray.append(data)
                    saveData()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    func updateData(id: Int, newName: String) {
//        fetchData.predicate = NSPredicate(format: "id = %d", id)
//        do {
//            if let result = try context?.fetch(fetchData) as? [NSManagedObject], let objectToUpdate = result.first {
//                objectToUpdate.setValue(newName, forKey: "name")
//                saveData()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
    func deleteData(taskName: String) {
        fetchData.predicate = NSPredicate(format: "taskname = %@", taskName)
        do {
            if let result = try context?.fetch(fetchData) as? [NSManagedObject], let objectToDelete = result.first {
                context?.delete(objectToDelete)
                saveData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CompleteTaskData {
    var completetask: String?
    var completeprioritylevel: String?
    var completedate: Date?
}
var completeTask  = CompleteTaskClass()
var completeArray: [CompleteTaskData] = [CompleteTaskData]()

class CompleteTaskClass {
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "CompleteTask")
    
    func addData(taskname: String,prioritylevel: String,date: Date) {
        let entity = NSEntityDescription.entity(forEntityName: "CompleteTask", in: context!)
        let newData = NSManagedObject(entity: entity!, insertInto: context)
        newData.setValue(taskname, forKey: "completetask")
        newData.setValue(prioritylevel, forKey: "completeprioritylevel")
        newData.setValue(date, forKey: "completedate")
        saveData()
    }
    
    private func saveData() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getData() {
        do {
            if let result = try context?.fetch(fetchData) as? [NSManagedObject] {
                for data in result {
                    let taskname = data.value(forKey: "completetask") as? String ?? ""
                    let prioritylevel = data.value(forKey: "completeprioritylevel") as? String ?? ""
                    let date = data.value(forKey: "completedate") as? Date
                    let data = CompleteTaskData(completetask: taskname,completeprioritylevel: prioritylevel, completedate: date)
                    completeArray.append(data)
                    saveData()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
