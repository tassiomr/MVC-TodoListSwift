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
	var selectedTask: Task?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		
		services = TaskService()
		self.setupNavigationBar()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.getTasks()
		self.selectedTask = nil;
		tableView.reloadData()
	}
	
	func setupNavigationBar () {
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = "Tasks"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddPage))
	}
	
	@objc func goToAddPage() {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		
		let controller = storyboard.instantiateViewController(withIdentifier: "addViewController") as! AddTaskViewController
		
		if self.selectedTask != nil {
			controller.task = self.selectedTask
		}
		
		navigationController?.pushViewController(controller, animated: true)
	}
	
	func getTasks() {
		tasks = self.services.read()
	}
	
	func deleteTask(indexPath: IndexPath) {
		let task = self.tasks[indexPath.row]
		self.tasks.remove(at: indexPath.row)
		tableView.reloadData()
		
		self.services.delete(task: task)
	}
	
	func selectFinish(task: Task) {
		task.toggle()
		self.tableView.reloadData()
		self.services.update(task: task)
	}
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = self.tasks[indexPath.row]
	
		let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TableViewCell
		cell.labelText?.text = task.title
		cell.isFinishedLabel?.text = task.isFinished ? "Finished" : "Not Finished"
		
		return cell;
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func uiContextualAction(style: UIContextualAction.Style, title: String, color: UIColor, handler: @escaping() -> Void) -> UIContextualAction {
		
		let uiButton = UIContextualAction(style: style, title: title) { (action, view, completion) in
			completion(true)
			handler()
			
		}
		uiButton.backgroundColor = color
		
		return uiButton
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let delete = uiContextualAction(style: .destructive, title: "Delete", color: .orange) {
			self.deleteTask(indexPath: indexPath)
		}
		
		let finish = uiContextualAction(style: .normal, title: "Finish", color: .gray) {
			self.selectFinish(task: self.tasks[indexPath.row])
		}
		
		let edit = uiContextualAction(style: .normal, title: "Edit", color: .magenta) {
			self.selectedTask = self.tasks[indexPath.row]
			self.goToAddPage()
		}
		
		let buttons = UISwipeActionsConfiguration(actions: [delete, finish, edit])
		return buttons
	}
}
