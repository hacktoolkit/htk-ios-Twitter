//
//  SidebarMenuItemCell.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/8/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class SidebarMenuItemCell: UITableViewCell {

    @IBOutlet weak var menuItemIcon: UILabel!
    @IBOutlet weak var menuItemLabel: UILabel!

    var menuItem:SidebarMenuItem! {
        willSet(newMenuItem) {
            self.menuItemIcon.font = UIFont(name: "FontAwesome", size: 20)
            self.menuItemIcon.text = newMenuItem.icon
            self.menuItemLabel.text = newMenuItem.name
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
