//
//  TweetCellView.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/26/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class TweetCellView: UITableViewCell {
    let RETWEET_VIEW_HEIGHT = 15

    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var retweeterLabel: UILabel!
    @IBOutlet weak var retweetViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var userThumbnailImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var shortTimestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!

    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    var tweet: Tweet! {
        willSet(newTweet) {
            var sourceTweet: Tweet
            if newTweet.retweetSource != nil {
                sourceTweet = newTweet.retweetSource!
                self.retweeterLabel?.text = "\(newTweet.user!.name!) retweeted"
                self.retweetViewHeightConstraint.constant = CGFloat(RETWEET_VIEW_HEIGHT)
            } else {
                // it wasn't retweeted, hide it
                self.retweetViewHeightConstraint?.constant = 0
                sourceTweet = newTweet
            }
            HTKImageUtils.sharedInstance.displayImageUrl(sourceTweet.user!.profileImageUrl!, imageView: self.userThumbnailImage)
            self.userNameLabel?.text = sourceTweet.user?.name!
            self.userScreennameLabel?.text = "@\(sourceTweet.user!.screenname!)"
//            self.tweetTextLabel?.enabledTextCheckingTypes = NSTextCheckingType.Link
            self.tweetTextLabel?.text = sourceTweet.text

            self.shortTimestampLabel?.text = sourceTweet.createdAt?.prettyTimestampSinceNow()

            if sourceTweet.retweeted! {
                retweetButton.setImage(
                    RETWEET_ON_IMAGE,
                    forState: UIControlState.Normal
                )
            }
            
            if sourceTweet.favorited! {
                favoriteButton.setImage(
                    FAVORITE_ON_IMAGE,
                    forState: UIControlState.Normal
                )
            }
        }

        didSet(oldTweet) {
            // do nothing
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        replyButton.setImage(
            REPLY_HOVER_IMAGE,
            forState: UIControlState.Highlighted
        )
        retweetButton.setImage(
            RETWEET_HOVER_IMAGE,
            forState: UIControlState.Highlighted
        )
        favoriteButton.setImage(
            FAVORITE_HOVER_IMAGE,
            forState: UIControlState.Highlighted
        )
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
