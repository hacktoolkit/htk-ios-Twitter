//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/30/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loginButton.layer.borderWidth = 2
        self.loginButton.layer.borderColor = UIColor.blackColor().CGColor
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.login(
            "htktwitter",
            path: "oauth",
            completion: {
                (user: TwitterUser?, error: NSError?) in
                if user != nil {
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                } else {
                    // handle login error
                }
            }
        )
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
