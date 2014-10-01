htk-ios-Twitter
============

This is a basic Twitter client.

[CodePath iOS Bootcamp](http://codepath.com/iosbootcamp) September 2014 - Week 3 Project

## GIF Screen Cap

Here's an animated GIF (made with [LiceCAP](http://www.cockos.com/licecap/)) of what it looks like:

![](https://raw.githubusercontent.com/hacktoolkit/htk-ios-Twitter/master/twitter_screencap_20140930.gif)

## Download and Build Instructions

* Clone the repository
* Install [CocoaPods](http://cocoapods.org/)
  * `sudo gem install cocoapods`
* Install Pods
  * `pod install`
* Set up API keys
  * Create a `secrets.xcconfig` config file based on `secrets.xcconfig.template`
  * Obtain API keys from the [Twitter Developers page](http://www.twitter.com/developers/manage_api_keys) and add the keys to `secrets.xcconfig`
* Run it!

## Features

'''Core User Stories'''

* [x] User can sign in using OAuth login flow
* [wip] User can view last 20 tweets from their home timeline
* [x] The current signed in user will be persisted across restarts
* [wip] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
* [0] User can pull to refresh
* [0] User can compose a new tweet by tapping on a compose button.
User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

'''Optional User Stories'''

* Optional: When composing, you should have a countdown in the upper right for the tweet limit.
* Optional: After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
* Optional: Retweeting and favoriting should increment the retweet and favorite count.
* Optional: User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
* Optional: Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
* Optional: User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.