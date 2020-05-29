//
//  Task.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 29/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit

struct Task {
    var isFinished: Bool
    var title: String
    var description: String
    var date: String
    
    init(isFinished: Bool = false, title: String, description: String) {
        self.isFinished = isFinished;
        self.title = title;
        self.description = description;
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        self.date = formatter.string(from: date)
    }
}
