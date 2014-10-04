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
    @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!

    var tweet: Tweet! {
        willSet(newTweet) {
            var sourceTweet: Tweet
            if newTweet.retweetSource != nil {
                sourceTweet = newTweet.retweetSource!
                self.retweeterLabel.text = "\(newTweet.user!.name!) retweeted"
            } else {
                // it wasn't retweeted, hide it
                self.retweetViewHeightConstraint.constant = 0
                sourceTweet = newTweet
            }
            HTKImageUtils.sharedInstance.displayImageUrl(sourceTweet.user!.profileImageUrl!, imageView: self.userThumbnailImage)
            self.userNameLabel?.text = sourceTweet.user?.name!
            self.userScreennameLabel?.text = "@\(sourceTweet.user!.screenname!)"
//            self.tweetTextLabel?.enabledTextCheckingTypes = NSTextCheckingType.Link
            self.tweetTextLabel?.text = sourceTweet.text
            self.shortTimestampLabel?.text = sourceTweet.createdAt?.prettyTimestampSinceNow()
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
