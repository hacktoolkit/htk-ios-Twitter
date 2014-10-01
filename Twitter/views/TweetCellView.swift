//
//  TweetCellView.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/26/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class TweetCellView: UITableViewCell {

    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var retweeterLabel: UILabel!
    @IBOutlet weak var retweetViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var userThumbnailImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var shortTimestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet! {
        willSet(newTweet) {
            if newTweet.retweeted! {
                self.retweeterLabel.text = "\(newTweet.user!.name!) retweeted"
            } else {
                // it wasn't retweeted, hide it
                self.retweetViewHeightConstraint.constant = 0
            }
            HTKImageUtils.sharedInstance.displayImageUrl(newTweet.user!.profileImageUrl!, imageView: self.userThumbnailImage)
            self.userNameLabel?.text = newTweet.user?.name!
            self.userScreennameLabel?.text = "@\(newTweet.user!.screenname!)"
            self.tweetTextLabel?.text = newTweet.text
        }

        didSet(oldTweet) {
            // do nothing
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
