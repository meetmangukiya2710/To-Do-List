//
//  ToDoListVC.swift
//  To Do List
//
//  Created by Meet Mangukiya on 05/09/24.
//

import UIKit

protocol UpdateData {
    func valueUpdate()
    func arrayValueDelete()
}

class ToDoListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateData {
    
    @IBOutlet weak var listTableOutlet: UITableView!
    
    @objc var refresh = UIRefreshControl()
    var refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskObj.getData()
        view.backgroundColor = UIColor.primaryColor
        isEmpty()
    }
    
    @IBAction func AddTaskBtn(_ sender: Any) {
        let navigation = storyboard?.instantiateViewController(identifier: "AddtaskVC") as! AddtaskVC
        navigation.protocolObj = self
        navigationController?.pushViewController(navigation, animated: true)
    }
    
    func valueUpdate() {
        NSLog("Delete Array Value 🥳")
        isEmpty()
        DispatchQueue.main.async { [self] in
            addTaskObj.getData()
            listTableOutlet.reloadData()
        }
    }
    
    func arrayValueDelete() {
        NSLog("Delete Array Value 🥳")
        isEmpty()
        addTaskObj.getData()
        listTableOutlet.reloadData()
    }
    
    func isEmpty() {
        if listTableOutlet.numberOfRows(inSection: 0) == 0 {
            let text = UILabel()
            text.text = "The list is empty"
            text.textAlignment = .center
            text.translatesAutoresizingMaskIntoConstraints = false
            
            if let parentView = listTableOutlet.superview {
                parentView.addSubview(text)
                NSLayoutConstraint.activate([
                    text.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
                    text.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
                ])
            }
        } else {
            print("The list has data")
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableOutlet.dequeueReusableCell(withIdentifier: "cell") as! ListTableCell
        let index = dataArray[indexPath.row]
        
        cell.taskNameLable.text = index.taskNmae
        cell.priorityLable.text = index.prioritylevel
        if let date = index.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date)
            cell.dateLable.text = dateString
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let didSelect = storyboard?.instantiateViewController(identifier: "Complete_UpdateVC") as! Complete_UpdateVC
        let index = dataArray[indexPath.row]
        didSelect.taskName = index.taskNmae!
        didSelect.priorityLevel = index.prioritylevel!
        if let date = index.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date)
            didSelect.date = date
        }
        didSelect.protocolObj = self
        navigationController?.pushViewController(didSelect, animated: true)
    }
    
}
