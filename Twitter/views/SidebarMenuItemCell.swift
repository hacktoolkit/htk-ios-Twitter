//
//  SidebarMenuItemCell.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/8/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class SidebarMenuItemCell: UITableViewCell {

    var menuItem:SidebarMenuItem! {
        willSet(newMenuItem) {
            
        }

        didSet(oldMenuItem) {
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
