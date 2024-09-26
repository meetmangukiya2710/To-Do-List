//
//  CompleteTaskVC.swift
//  To Do List
//
//  Created by R95 on 26/09/24.
//

import UIKit

class CompleteTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var completeTaskList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompleteTaskCell
        cell.taskName.text = completeArray[indexPath.row].completetask
        cell.priorityLevel.text = completeArray[indexPath.row].completeprioritylevel
        if let date = completeArray[indexPath.row].completedate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date)
            cell.date.text = dateString
        }
        return cell
    }
    
}
