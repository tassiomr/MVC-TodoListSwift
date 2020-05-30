//
//  TaskService.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 29/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TaskService {
	
	var appDelegate: AppDelegate!;
	
	init() {
		
		guard let instanceDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		self.appDelegate = instanceDelegate;
	}
	
	func create(task: Task) {
		if((appDelegate) == nil) {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext;
		guard let taskEntity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: managedContext) else { return };
		
		let taskRaw = NSManagedObject(entity: taskEntity, insertInto: managedContext);
		taskRaw.setValue(task.id, forKey: "id");
		taskRaw.setValue(task.title, forKey: "title");
		taskRaw.setValue(task.date, forKey: "date");
		taskRaw.setValue(task.create_at, forKey: "create_at");
		taskRaw.setValue(task.update_at, forKey: "update_at");
		taskRaw.setValue(task.description, forKey: "descript")
		taskRaw.setValue(task.isFinished, forKey: "isFinished")
		
		do {
			try managedContext.save()
		} catch {
			print(error)
		}
	}
	
	func delete(task: Task) {
		if((appDelegate) == nil) {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext;
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity");
		
		fetchRequest.predicate = NSPredicate(format: "id = %@", task.id);
		
		do {
			let result = try managedContext.fetch(fetchRequest)
			
			let objToDelete = result[0] as! NSManagedObject;
			managedContext.delete(objToDelete);
			try managedContext.save()
		} catch {
			print(error)
		}
	}
	
	
	func update(task: Task) {
		if((appDelegate) == nil) {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext;
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity");
		fetchRequest.predicate = NSPredicate(format: "id = %@", task.id);
		
		do {
			let result = try managedContext.fetch(fetchRequest);
			
			let taskEntity = result[0] as! NSObject
			taskEntity.setValue(task.id, forKey: "id");
			taskEntity.setValue(task.title, forKey: "title");
			taskEntity.setValue(task.date, forKey: "date");
			taskEntity.setValue(task.date, forKey: "create_at");
			taskEntity.setValue(task.date, forKey: "update_at");
			taskEntity.setValue(task.description, forKey: "descript")
			taskEntity.setValue(task.isFinished, forKey: "isFinished")
			
			try! managedContext.save()
			
		} catch {
			print(error)
		}
	}
	
	func read() -> [Task] {
		if(appDelegate == nil) {
			return []
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext;
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity");
		
		do {
			let result = try managedContext.fetch(fetchRequest)
			var tasks = [Task]()
			
			for task in result as! [NSManagedObject] {
				let id = task.value(forKey: "id") as! String
				let isFinished = task.value(forKey: "isFinished") as! Bool
				let title = task.value(forKey: "title") as! String
				let date = task.value(forKey: "date") as! String
				let description = task.value(forKey: "descript") as! String
				let create_at = task.value(forKey: "create_at") as! String
				let update_at = task.value(forKey: "update_at") as! String
				
				let rawTask = Task(id: id, isFinished: isFinished, title: title, description: description, create_at: create_at, update_at: update_at, date: date)
				tasks.append(rawTask);
			}
			return tasks
		} catch {
			return []
		}
	}
	
}
