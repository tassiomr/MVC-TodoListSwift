//
//  TableViewCell.swift
//  MVC-TodoListSwift
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
	
	@IBOutlet var labelText: UILabel?
	@IBOutlet var isFinishedLabel: UILabel?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
