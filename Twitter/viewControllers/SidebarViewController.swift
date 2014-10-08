//
//  SidebarViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

class SidebarViewController: UIViewController {

    @IBOutlet weak var sidebarView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var contentViewXConstraint: NSLayoutConstraint!

    var viewControllers: [String: UIViewController] = [
        "Nav" : mainStoryboard.instantiateViewControllerWithIdentifier("TwitterNavigationController") as TwitterNavigationController,
        "Home" : mainStoryboard.instantiateViewControllerWithIdentifier("TweetsViewController") as TweetsViewController,
        "Profile" : mainStoryboard.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController,
    ]

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
        self.contentViewXConstraint.constant = 0
        self.activeViewController = self.viewControllers["Profile"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSidebarButton(sender: UIButton) {
        self.contentViewXConstraint.constant = 0
        if sender == homeButton {
           println("Home Button")
            self.activeViewController = self.viewControllers["Nav"]
        } else if sender == profileButton {
            println("Profile Button")
            self.activeViewController = self.viewControllers["Nav"]
        }
    }

    @IBAction func didSwipeOverContentView(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            self.contentViewXConstraint.constant = -160
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
