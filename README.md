ios_facebook_state
==================

[prototyping] Facebook State iOS App

This is an iOS prototyping application, which implement the Facebook login flow with loading and error states.

## Walkthrough of all user stories

[![image](https://raw.githubusercontent.com/wiki/stanleyhlng/ios_facebook_state/assets/ios_facebook_state.gif)](https://raw.githubusercontent.com/wiki/stanleyhlng/ios_facebook_state/assets/ios_facebook_state.gif)

## Completed user stories
 * Facebook login page
  * [x] Required: Tapping in the UITextField repositions the elements, as shown in the screenshots.
  * [x] Required: Tapping anywhere dismisses the keyboard.
  * [x] Required: If email and password field are both blank, button should be disabled.
  * [x] Required: Password field should be secure with no autocorrection.
  * [x] Required: After tapping log in button, show the loading indicator in the button. After a 2 second delay, check the password.
   * If the password is 'password', transition to the next screen.
   * If the password is anything else, display the password error alert.
 * Facebook feed
  * [x] Required: Navigation bar should have the search button and messages button.
  * [x] Required: Immediately after launch, display the loading indicator.
  * [x] Required: After 2 seconds, show the feed, which is a long image in a scrollable view.
  * [x] Optional: Tapping the status button should show the compose view w/ the keyboard (optional)
 * More
  * [x] Optional: Add a scrollable view of the "More" page.
  * [x] Optional: Upon tapping Log Out, return to the login screen.
  * [x] Optional: Add a UIRefreshControl for a pull to refresh.
  * [x] Optional: After a pull to refresh, delay for 2 seconds before ending.
  * [x] Optional: Every other time, display an error message.

## Time spent
12 hours spent in total

## Learnings
 * Events and Delegates
   * Events via targets and selectors
   * Delegation for simple controls like UIAlertView and UIActionSheet
   * Handling UITextField delegate events
   * Handling scroll view events
   * Observing properties using KVO
 * Application states
   * Mocking an transient loading state
   * Transitioning between empty and populated states
   * Performing selectors after delays

## Libraries
 * AVHexColor 1.2.0
 * Reveal-iOS-SDK 1.0.4
