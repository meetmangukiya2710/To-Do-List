//
//  AddtaskVC.swift
//  To Do List
//
//  Created by R95 on 05/09/24.
//

import UIKit

class AddtaskVC: UIViewController {
    
    @IBOutlet weak var taskNametextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var priorityLevel: UISegmentedControl!
    
    var taskArray: [TaskData] = []
    var taskName = ""
    var protocolObj: UpdateData?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        addData()
    }
    
    func addData() {
        let selectedDate = datePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        let selectedPriorityIndex = priorityLevel.selectedSegmentIndex
        let priority: String
        switch selectedPriorityIndex {
        case 0:
            priority = "Low"
        case 1:
            priority = "Medium"
        case 2:
            priority = "High"
        default:
            priority = "Unknown"
        }
        
        if let name = taskNametextField.text {
            taskName = name
        }
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        let fireDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        
        content.title = taskName
        content.body = priority
        content.sound = .default
        content.userInfo = ["Value": "Notification Scheduled"]
        
        let notificationID = "Notification-\(Date().timeIntervalSince1970)"
        print(notificationID)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                NSLog("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                NSLog("Notification scheduled successfully!")
            }
        }
        
        addTaskObj.addData(taskname: taskName, prioritylevel: priority, date: selectedDate)
        dataArray.removeAll()
        protocolObj?.valueUpdate()
        navigationController?.popViewController(animated: true)
    }
}
