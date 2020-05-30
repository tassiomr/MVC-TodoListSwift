//
//  AddTaskViewController.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var descriptionTextArea: UITextView!
	@IBOutlet weak var toggle: UISwitch!
	
	var service: TaskService!
	var task: Task?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		service = TaskService()
		titleTextField.delegate = self;
		descriptionTextArea.delegate = self;
		
		// Do any additional setup after loading the view.
		self.setupUI()
	}
	
	
	func setupUI () {
		navigationItem.title = "New Task"
	}
	
	
	@IBAction func creteTask(){
		if let title = titleTextField.text {
			self.service.create(task: Task(title: title, description: descriptionTextArea.text ?? ""))
		}
		
		navigationController?.popViewController(animated: true)
	}
}

extension AddTaskViewController : UITextViewDelegate, UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			textView.resignFirstResponder()
			return false
		}
		
		return true
	}

}
