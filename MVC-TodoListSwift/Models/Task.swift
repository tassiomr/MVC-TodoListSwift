//
//  Task.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 29/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit
import Foundation

class Task {
    var id: String
    var isFinished: Bool
    var title: String
    var description: String
    var date: String
    var create_at: String
    var update_at: String
   
    
    init(id: String = UUID().uuidString,
         isFinished: Bool = false,
         title: String,
         description: String,
         create_at: String? = nil,
         update_at: String? = nil,
         date: String? = nil) {
        
        self.isFinished = isFinished;
        self.title = title;
        self.description = description;
        self.id = id;
        
        let dateNow = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: dateNow)
        
        self.date = date ?? result;
        self.create_at = create_at ?? result
        self.update_at = update_at ?? result
    }
    
    func toggle()  {
        self.isFinished = !self.isFinished
    }
    

}
