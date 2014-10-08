//
//  SidebarViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak private var sidebarView: UIView!
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var contentViewXConstraint: NSLayoutConstraint!

    @IBOutlet weak var userHeadingView: UIView!
    @IBOutlet weak var userThumbnailImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var userTaglineLabel: UILabel!

    @IBOutlet weak var menuItemsTableView: UITableView!

    private var viewControllers = [String: UIViewController]()
    private var menuItems = [SidebarMenuItem]()

    var activeViewController: UIViewController? {
        didSet(oldViewControllerOrNil) {
            if let oldVC = oldViewControllerOrNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideMenu()
        self.initializeChildViewControllers()
        self.renderSidebar()
        self.activateViewControllerForKey("Home")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initializeChildViewControllers() {
        var viewControllers = [String:UIViewController]()
        for menuItemSetting in MENU_ITEMS_SETTINGS {
            var key = menuItemSetting["key"]!
            var viewControllerName = menuItemSetting["viewController"]!
            viewControllers[key] = initializeChildViewControllerWithIdentifier(viewControllerName)
        }
        self.viewControllers = viewControllers
    }

    private func initializeChildViewControllerWithIdentifier(identifier: String) -> TwitterViewController {
        var vc = mainStoryboard.instantiateViewControllerWithIdentifier(identifier) as TwitterViewController
        vc.setSidebarViewController(self)
        return vc
    }

    private func renderSidebar() {
        var currentUser = TwitterUser.currentUser
        if let currentUser = currentUser {
            HTKImageUtils.sharedInstance.displayImageUrl(currentUser.profileImageUrl!, imageView: self.userThumbnailImage)
            self.userNameLabel.text = currentUser.name!
            self.userScreennameLabel.text = "@\(currentUser.screenname!)"
            self.userTaglineLabel.text = currentUser.tagline!
        }
        self.generateMenuItems()
    }

    private func generateMenuItems() {
        var menuItems = [SidebarMenuItem]()

        for menuItemSetting in MENU_ITEMS_SETTINGS {
            var menuItem = SidebarMenuItem(settings: menuItemSetting)
            menuItems.append(menuItem)
        }
        self.menuItems = menuItems
    }

    private func showMenu() {
        self.contentViewXConstraint.constant = -CGFloat(SIDEBAR_MENU_WIDTH)
    }

    private func hideMenu() {
        self.contentViewXConstraint.constant = 0
    }

    private func activateViewControllerForKey(key: String) {
        self.activeViewController = self.viewControllers[key]!
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = self.menuItems.count
        return numRows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var menuItemCell = tableView.dequeueReusableCellWithIdentifier("SidebarMenuItemCell") as SidebarMenuItemCell
        var menuItem = self.menuItems[indexPath.row]
        menuItemCell.menuItem = menuItem
        return menuItemCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var menuItem = self.menuItems[indexPath.row]
        self.activateViewControllerForKey(menuItem.key)
        hideMenu()
    }

    @IBAction func didSwipeOverContentView(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            showMenu()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
