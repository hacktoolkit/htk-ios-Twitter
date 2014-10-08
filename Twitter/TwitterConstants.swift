//
//  TwitterConstants.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/7/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import Foundation

let SIDEBAR_MENU_WIDTH = 180

// Images

let REPLY_NORMAL_IMAGE = UIImage(named: "reply")
let REPLY_HOVER_IMAGE = UIImage(named: "reply_hover")

let RETWEET_NORMAL_IMAGE = UIImage(named: "retweet")
let RETWEET_ON_IMAGE = UIImage(named: "retweet_on")
let RETWEET_HOVER_IMAGE = UIImage(named: "retweet_hover")

let FAVORITE_NORMAL_IMAGE = UIImage(named: "favorite")
let FAVORITE_ON_IMAGE = UIImage(named: "favorite_on")
let FAVORITE_HOVER_IMAGE = UIImage(named: "favorite_hover")

// Globals

let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

// Menu Items

let MENU_ITEMS_SETTINGS: [[String:String]] = [
    [
        "name" : "Home Timeline",
        "icon" : NSString.awesomeIcon(FaTwitter),
        "key" : "Home",
        "viewController" : "TweetsViewController",
    ],
    [
        "name" : "Profile",
        "icon" : NSString.awesomeIcon(FaUser),
        "key" : "Profile",
        "viewController" : "ProfileViewController",
    ],
    [
        "name" : "Mentions",
        "icon" : NSString.awesomeIcon(FaCommentO),
        "key" : "Mentions",
        "viewController" : "MentionsViewController",
    ],
    [
        "name" : "Settings",
        "icon" : NSString.awesomeIcon(FaCog),
        "key" : "Settings",
        "viewController" : "SettingsViewController",
    ],
    [
        "name" : "Log Out",
        "icon" : NSString.awesomeIcon(FaSignOut),
        "key" : "Logout",
        "viewController" : "SettingsViewController",
    ]
]
