//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/30/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    let RETWEET_VIEW_HEIGHT = 15

    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var retweeterLabel: UILabel!
    @IBOutlet weak var retweetViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userThumbnailImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!

    @IBOutlet weak var timestampLabel: UILabel!

    @IBOutlet weak var retweetCountsLabel: UILabel!
    @IBOutlet weak var favoriteCountsLabel: UILabel!

    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formatWithTweet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func formatWithTweet() {
        var sourceTweet: Tweet
        if self.tweet.retweetSource != nil {
            sourceTweet = self.tweet.retweetSource!
            self.retweeterLabel?.text = "\(self.tweet.user!.name!) retweeted"
            self.retweetViewHeightConstraint.constant = CGFloat(RETWEET_VIEW_HEIGHT)
        } else {
            // it wasn't retweeted, hide it
            self.retweetViewHeightConstraint?.constant = 0
            sourceTweet = self.tweet
        }
        HTKImageUtils.sharedInstance.displayImageUrl(sourceTweet.user!.profileImageUrl!, imageView: self.userThumbnailImage)
        self.userNameLabel?.text = sourceTweet.user?.name!
        self.userScreennameLabel?.text = "@\(sourceTweet.user!.screenname!)"
        //            self.tweetTextLabel?.enabledTextCheckingTypes = NSTextCheckingType.Link
        self.tweetTextLabel?.text = sourceTweet.text
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm:ss"
        self.timestampLabel?.text = dateFormatter.stringFromDate(sourceTweet.createdAt!)

        self.retweetCountsLabel?.text = "\(sourceTweet.retweetCount!)"
        self.favoriteCountsLabel?.text = "\(sourceTweet.favoriteCount!)"
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
