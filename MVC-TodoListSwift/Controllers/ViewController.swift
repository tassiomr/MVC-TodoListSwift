//
//  ViewController.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 29/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var services: TaskService!;
    var tasks = [Task]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        services = TaskService()
        self.setupNavigationBar()
        self.getTasks()
    }
    
    func getTasks() {
        tasks = self.services.read()
    }
    
    func deleteTask(task: Task) {
        self.services.delete(task: task)
    }
    
    func selectFinish(task: Task) {
        task.toggle()
        
        self.services.update(task: task)
    }
    
    
    func setupNavigationBar () {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Tasks"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddPage))
        
    }
    
    @objc func goToAddPage() {
        let controller = UIViewController()
        controller.view.backgroundColor = .purple
        
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.tasks.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let ordered = self.tasks.sorted { (task1, task2) -> Bool in
               task1.isFinished as AnyObject !== task2.isFinished as AnyObject
           }
           
           let task = ordered[indexPath.row]
           
           let cell: UITableViewCell = UITableViewCell()
           cell.textLabel?.text = task.title
           cell.detailTextLabel?.text = task.description
           
           if(task.isFinished) {
               cell.backgroundColor = .red
           } else {
               cell.backgroundColor = .green
           }
           
           return cell;
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
       }

       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let delete = UIContextualAction(style: .destructive, title: "Delete") {_,_,completeHandler in
               completeHandler(true)
               print("delete")
           }
           delete.backgroundColor = .orange
           
           let finish = UIContextualAction(style: .normal, title: "Finish") { (_, _, completeHandler) in
               completeHandler(true)
               self.selectFinish(task: self.tasks[indexPath.row])
               tableView.reloadData()
           }
           finish.backgroundColor = .gray
           
           let buttons = UISwipeActionsConfiguration(actions: [delete, finish])
           return buttons
       }
    
}
