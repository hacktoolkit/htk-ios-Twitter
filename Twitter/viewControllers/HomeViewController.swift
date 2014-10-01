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

    let PAGE_SIZE = 20
    let INFINITE_SCROLL_THRESHOLD = 5
    var IS_LOADING = false
    var OLDEST_TWEET: Tweet?

    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160;
        getHomeTweets()
    }

    func getHomeTweets(loadMore: Bool = false) {
        var params = [
            "count" : PAGE_SIZE,
        ]
        if (loadMore && self.OLDEST_TWEET != nil) {
            params["max_id"] = self.OLDEST_TWEET!.id
        }
        self.IS_LOADING = true
        TwitterClient.sharedInstance.getHomeTimelineWithParams(
            params,
            callback: {
                (tweets: [Tweet]?, error: NSError?) -> Void in
                self.IS_LOADING = false
                if tweets != nil {
                    self.tweets.extend(tweets!)
                    self.OLDEST_TWEET = self.tweets[self.tweets.count - 1]
                    self.tableView.reloadData()
                }
            }
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func triggerInfiniteScroll(atRow: Int) {
        if !self.IS_LOADING &&
            self.tweets.count > INFINITE_SCROLL_THRESHOLD &&
            atRow + INFINITE_SCROLL_THRESHOLD >= self.tweets.count {
                getHomeTweets(loadMore: true)
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

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)

        var tweet = self.tweets[indexPath.row]
        var tweetDetailsViewController = TweetDetailsViewController(nibName: nil, bundle: nil)
        tweetDetailsViewController.tweet = tweet
        self.navigationController?.pushViewController(tweetDetailsViewController, animated: true)
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
