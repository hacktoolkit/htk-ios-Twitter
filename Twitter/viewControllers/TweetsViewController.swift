//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jonathan Tsai on 9/26/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

enum TweetsViewMode {
    case Home
    case User
}

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var tableView: UITableView!

    var refreshControl: UIRefreshControl?

    let PAGE_SIZE = 20
    let INFINITE_SCROLL_THRESHOLD = 5
    var IS_LOADING = false
    var OLDEST_TWEET: Tweet?
    var viewMode = TweetsViewMode.Home

    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: tableView is nil at this point, for some reason
        NSLog("test")
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // auto layout stuff
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160;

        // pull to refresh
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl?.addTarget(self, action: "tableRefreshCallback:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView!.addSubview(refreshControl!)

        // data
        getTweets()
    }

    func tableRefreshCallback(refreshControl: UIRefreshControl) {
        getTweets(loadMore: false, resetData: true)
    }

    func insertTweet(tweet: Tweet) {
        self.tweets.insert(tweet, atIndex: 0)
        self.tableView.reloadData()
    }

    func getTweets(loadMore: Bool = false, resetData: Bool = false) {
        var params: [String:AnyObject] = [
            "count" : PAGE_SIZE,
        ]
        if (loadMore && self.OLDEST_TWEET != nil) {
            params["max_id"] = self.OLDEST_TWEET!.id
        }
        self.IS_LOADING = true
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // construct the callback
        var tweetsCallback = {
            (tweets: [Tweet]?, error: NSError?) -> Void in
            self.IS_LOADING = false
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.refreshControl?.endRefreshing()
            if tweets != nil {
                if resetData {
                    // wipe/refresh tweets in the case of pull to refresh
                    self.tweets = tweets!
                } else {
                    // keep extending in the case of infinite scroll
                    self.tweets.extend(tweets!)
                }
                self.OLDEST_TWEET = self.tweets[self.tweets.count - 1]
                self.tableView.reloadData()
            }
        }

        // actually make the network call
        switch self.viewMode {
        case TweetsViewMode.Home:
            TwitterClient.sharedInstance.getHomeTimelineWithParams(
                params,
                callback: tweetsCallback
            )
        case TweetsViewMode.User:
            if TwitterUser.currentUser != nil {
                TwitterClient.sharedInstance.getTimelineForUsername(
                    TwitterUser.currentUser!.screenname!,
                    params: params,
                    callback: tweetsCallback
                )
            } else {
                NSLog("No current user")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func triggerInfiniteScroll(atRow: Int) {
        if !self.IS_LOADING &&
            self.tweets.count > INFINITE_SCROLL_THRESHOLD &&
            atRow + INFINITE_SCROLL_THRESHOLD >= self.tweets.count {
                getTweets(loadMore: true)
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = self.tweets.count
        return value
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        triggerInfiniteScroll(indexPath.row)
        var tweetCell = self.tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCellView
        let tweet = self.tweets[indexPath.row]
        tweetCell.tweet = tweet

        return tweetCell
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)

        var tweet = self.tweets[indexPath.row]
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var tweetDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetDetailsViewController") as TweetDetailsViewController
        tweetDetailsViewController.tweet = tweet
        self.navigationController?.pushViewController(tweetDetailsViewController, animated: true)
    }

    @IBAction func onLogout(sender: AnyObject) {
        TwitterUser.currentUser?.logout()
    }

    @IBAction func onUserThumbnailTap(sender: UITapGestureRecognizer) {
        NSLog("user image tapped")
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
