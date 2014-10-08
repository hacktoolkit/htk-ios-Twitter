//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class ProfileViewController: TwitterViewController {

    @IBOutlet weak private var userHeadingView: UIView!
    @IBOutlet weak private var userProfileImageView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var userScreenameLabel: UILabel!

    @IBOutlet weak private var numTweetsLabel: UILabel!
    @IBOutlet weak private var numFollowingLabel: UILabel!
    @IBOutlet weak private var numFollowersLabel: UILabel!

    var user: TwitterUser!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.renderUserProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func renderUserProfile() {
        HTKImageUtils.sharedInstance.displayImageUrl(user.profileImageUrl!, imageView: self.userProfileImageView)
        self.userNameLabel.text = user.name!
        self.userScreenameLabel.text = "@\(user.screenname)"
        self.numTweetsLabel.text = "\(user.numTweets!)"
        self.numFollowingLabel.text = "\(user.friendsCount!)"
        self.numFollowersLabel.text = "\(user.followersCount!)"

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
