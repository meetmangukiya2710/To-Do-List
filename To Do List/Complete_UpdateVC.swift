//
//  Complete_UpdateVC.swift
//  To Do List
//
//  Created by R95 on 05/09/24.
//

import UIKit

class Complete_UpdateVC: UIViewController {
    
    @IBOutlet weak var taskNameOutlet: UITextField!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var priorityLevelOutlet: UISegmentedControl!
    
    var taskName: String = ""
    var date: Date?
    var priorityLevel: String = ""
    var count = 0
    var protocolObj: UpdateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameOutlet.text = taskName
        if let date = date {
            datePickerOutlet.date = date
        }
        
        switch priorityLevel {
        case "Low":
            priorityLevelOutlet.selectedSegmentIndex = 0
        case "Medium":
            priorityLevelOutlet.selectedSegmentIndex = 1
        case "High":
            priorityLevelOutlet.selectedSegmentIndex = 2
        default:
            priorityLevelOutlet.selectedSegmentIndex = 0
        }
    }
    
    //MARK: Delete Task
    @IBAction func completeTaskAction(_ sender: Any) {
        completeTask.addData(taskname: taskName, prioritylevel: priorityLevel, date: datePickerOutlet.date)
        addTaskObj.deleteData(taskName: taskName)
        for i in dataArray {
            if i.taskNmae == taskName {
                dataArray.remove(at: count)
                break
            }
            count += 1
        }
    }
    
    //MARK: Delete Task
    @IBAction func deleteTaskAction(_ sender: Any) {
        addTaskObj.deleteData(taskName: taskName)
        for i in dataArray {
            if i.taskNmae == taskName {
                dataArray.remove(at: count)
                break
            }
            count += 1
        }
        protocolObj?.arrayValueDelete()
        
        let center = UNUserNotificationCenter.current()
        
        center.getPendingNotificationRequests { [self] requests in
            for request in requests {
                if taskName == request.content.title && priorityLevel == request.content.body {
                    removeNotification(notificationID: request.identifier)
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func removeNotification(notificationID: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
}
