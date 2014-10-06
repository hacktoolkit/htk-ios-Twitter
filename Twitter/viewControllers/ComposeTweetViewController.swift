//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/30/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    let TWEET_LENGTH_LIMIT = 120

    @IBOutlet weak var charCountLabel: TTTAttributedLabel!
    @IBOutlet weak var userThumbnailImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tweetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let currentUser = TwitterUser.currentUser {
            HTKImageUtils.sharedInstance.displayImageUrl(currentUser.profileImageUrl!, imageView: self.userThumbnailImage)
            self.userNameLabel.text = currentUser.name
            self.userScreennameLabel.text = currentUser.screenname
            self.charCountLabel.text = "\(TWEET_LENGTH_LIMIT)"
            self.tweetTextView.text = ""
            self.tweetTextView.becomeFirstResponder()
            self.updateCharCount()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTweetButton(sender: AnyObject) {
        var tweetLength = self.getTweetLength()
        if tweetLength <= TWEET_LENGTH_LIMIT {
            // TODO: post the tweet
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func getTweetLength() -> Int {
        var tweetLength = NSString(string: self.tweetTextView.text!).length
        return tweetLength
    }
    func updateCharCount() {
        var charsRemaining = TWEET_LENGTH_LIMIT - self.getTweetLength()
        self.charCountLabel.text = "\(charsRemaining)"
        if charsRemaining > 0 {
            self.charCountLabel.textColor = UIColor.blackColor()
        } else {
            self.charCountLabel.textColor = UIColor.redColor()
        }
    }

    func textViewDidChange(textView: UITextView) {
        self.updateCharCount()
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
