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
            var sourceTweet = newTweet.getSource()
            if newTweet.wasRetweeted() {
                self.retweeterLabel?.text = "\(newTweet.user!.name!) retweeted"
                self.retweetViewHeightConstraint.constant = CGFloat(RETWEET_VIEW_HEIGHT)
            } else {
                // it wasn't retweeted, hide it
                self.retweetViewHeightConstraint?.constant = 0
            }
            HTKImageUtils.sharedInstance.displayImageUrl(sourceTweet.user!.profileImageUrl!, imageView: self.userThumbnailImage)
            self.userNameLabel?.text = sourceTweet.user?.name!
            self.userScreennameLabel?.text = "@\(sourceTweet.user!.screenname!)"
//            self.tweetTextLabel?.enabledTextCheckingTypes = NSTextCheckingType.Link
            self.tweetTextLabel?.text = sourceTweet.text

            self.shortTimestampLabel?.text = sourceTweet.createdAt?.prettyTimestampSinceNow()

            self.updateButtonImages()
        }

        didSet(oldTweet) {
            // do nothing
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupButtonImages()
    }

    func setupButtonImages() {
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

    func updateButtonImages() {
        if self.tweet != nil {
            var tweet = self.tweet!
            replyButton.setImage(
                tweet.getSource().didReply ? REPLY_HOVER_IMAGE : REPLY_NORMAL_IMAGE,
                forState: UIControlState.Normal
            )
            retweetButton.setImage(
                tweet.retweeted! ? RETWEET_ON_IMAGE : RETWEET_NORMAL_IMAGE,
                forState: UIControlState.Normal
            )
            favoriteButton.setImage(
                tweet.favorited! ? FAVORITE_ON_IMAGE : FAVORITE_NORMAL_IMAGE,
                forState: UIControlState.Normal
            )
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onControlButton(sender: UIButton) {
        if sender == replyButton {
            NSLog("Reply button")
//            doReply()
        } else if sender == retweetButton {
            NSLog("Retweet button")
            // TODO: pass in a callback to revert the optimistic image update
            self.tweet.toggleRetweet({})
        } else if sender == favoriteButton {
            NSLog("Favorite button")
            // TODO: pass in a callback to revert the optimistic image update
            self.tweet.toggleFavorite({})
        } else {
            NSLog("Unknown button")
        }
        self.updateButtonImages()
    }

}
