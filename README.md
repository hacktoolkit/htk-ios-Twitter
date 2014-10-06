htk-ios-Twitter
============

This is a basic Twitter client.

[CodePath iOS Bootcamp](http://codepath.com/iosbootcamp) September 2014 - Week 3 Project

## GIF Screen Cap

Here's an animated GIF (made with [LiceCAP](http://www.cockos.com/licecap/)) of what it looks like:

![](https://raw.githubusercontent.com/hacktoolkit/htk-ios-Twitter/master/twitter_screencap_20141006.gif)

## Download and Build Instructions

* Clone the repository
* Install [CocoaPods](http://cocoapods.org/)
  * `sudo gem install cocoapods`
* Install Pods
  * `pod install`
* Update/initialize the [hacktoolkit-ios_lib](https://github.com/hacktoolkit/hacktoolkit-ios_lib) submodule (temporary step until CocoaPods supports Swift source files natively)
  * `git submodule init`
  * `git submodule update`
* Set up API keys
  * Create a `secrets.xcconfig` config file based on `secrets.xcconfig.template`
  * Obtain API keys from the [Twitter Developers page](http://www.twitter.com/developers/manage_api_keys) and add the keys to `secrets.xcconfig`
* Run it!

## Features

### Part 1 - Basic Twitter Client

Time spent: 26 hours

**Core User Stories**

* [x] User can sign in using OAuth login flow
* [x] User can view last 20 tweets from their home timeline
* [x] The current signed in user will be persisted across restarts
* [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. 
* [x] User can pull to refresh
* [x] User can compose a new tweet by tapping on a compose button.
* [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

**Optional User Stories**

* [x] Countdown in the upper right for the Tweet limit. Turns red and prevents posting Tweet when it exceeds the limit.
* [x] After creating a new tweet, a user can view it in the timeline immediately without refetching the timeline from the network.
* [x] Retweeting and favoriting increments the retweet and favorite count.
* [x] User can unretweet and unfavorite, and decrements the retweet and favorite count.
* [x] Replies are prefixed with the username and the reply_id is set when posting the tweet,
* [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Part 2 - Twitter Redux

* Hamburger menu
  * Dragging anywhere in the view should reveal the menu.
  * The menu should include links to your profile, the home timeline, and the mentions view.
  * The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI.

* Profile page
  * Contains the user header view
  * Contains a section with the users basic stats: # tweets, # following, # followers
  * Optional: Implement the paging view for the user description.
  * Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
  * Optional: Pulling down the profile page should blur and resize the header image.

* Home Timeline
  * Tapping on a user image should bring up that user's profile page

* Optional: Account switching
  * Long press on tab bar to bring up Account view with animation
  * Tap account to switch to
  * Include a plus button to Add an Account
  * Swipe to delete an account
