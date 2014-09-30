//
//  HomeViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/26/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.getHomeTimelineWithParams(
            nil,
            callback: {
                (tweets: [Tweet]?, error: NSError?) -> Void in
                if tweets != nil {
                    self.tweets = tweets!
                    self.tableView.reloadData()
                }
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = self.tweets.count
        return value
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tweetCell = self.tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCellView
        let tweet = self.tweets[indexPath.row]
        tweetCell.tweet = tweet

        return tweetCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var tweet = self.tweets[indexPath.row]
        println("pressed on a tweet")
    }

    @IBAction func onLogout(sender: AnyObject) {
        TwitterUser.currentUser?.logout()
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
