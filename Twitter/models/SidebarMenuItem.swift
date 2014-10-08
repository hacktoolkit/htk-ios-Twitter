//
//  SidebarMenuItem.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/8/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import Foundation

class SidebarMenuItem {
    var name: String
    var icon: String
    var key: String
    var viewControllerName: String

    init(settings: [String:String]) {
        self.name = settings["name"]!
        self.icon = settings["icon"]!
        self.key = settings["key"]!
        self.viewControllerName = settings["viewController"]!
    }
    
}
