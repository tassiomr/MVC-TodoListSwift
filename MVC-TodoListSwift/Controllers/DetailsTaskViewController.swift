//
//  DetailsTaskViewController.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit

class DetailsTaskViewController: UIViewController {
	
	@IBOutlet weak var descriptionLabel: UITextView?
	@IBOutlet weak var createAtLabel: UILabel?
	@IBOutlet weak var isFinished: UISwitch?
	
	var task: Task!
	var service: TaskService!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setup()
		// Do any additional setup after loading the view.
	}
	
	func setup() {
		service = TaskService()
		navigationItem.title = task.title
		if task.description.count > 0 {
			descriptionLabel?.text = task.description
		} else {
			descriptionLabel?.text = "Don't have description"
		}
		
		isFinished?.isOn = task.isFinished
		createAtLabel?.text = "Created at: \(task.create_at)"
		
		isFinished?.addTarget(self, action: #selector(whenSwicthChangeValue(_:)), for: .valueChanged)
	}
	
	@objc func whenSwicthChangeValue(_ sender:UISwitch!) {
		self.task.toggle()
		self.service.update(task: task)
	}
}
