---
layout: module
permalink: /module/HipchatPS/
---
# [HipchatPS](https://atlassianps.org/module/HipchatPS)

![License](https://img.shields.io/badge/license-MIT-blue.svg)

> **This code is not yet fully implemented.** Any help (including bug reporting) is appreciated.

A module for PowerShell with functions for interacting with the team chat tool "Hipchat" by Atlassian. The module utilises Hipchat API v2: https://www.hipchat.com/docs/apiv2.

Join the conversation on [![SlackLogo][] AtlassianPS.Slack.com](https://atlassianps.org/slack)

[SlackLogo]: https://atlassianps.org/assets/img/Slack_Mark_Web_28x28.png
<!--more-->

---

## Commands

The following functions are available:

#### 1. Send-HipChat

For sending notifications into a room. Before you can use this you need to create an API v2 token for the room that you want to send notifications to. 

To do this:

1. Go to https://yourdomain.hipchat.com/admin/rooms/ and select the room you wish to notify.
2. Go to Tokens.
3. Create a Send Notification token. Note the "Label" you define will be included with the notification.

> **Beware, tokens here: https://yourdomain.hipchat.com/admin/api will not work, these are for API v1.**

##### Example

Attempt to send a message to a room named "My Room" coloured green. Will retry 5 additional times if it fails, waiting 30 seconds between each attempt. Will write verbose output to console.
    
	Send-HipChat -message "my message" -room "My%20Room" -apitoken a1b2c3d4e5f6a1b2c3d4e5f6 -color green -verbose -retry 5 -retrysec 30

## Acknowledgments

* Thanks to [@markwragg] for getting this module on it's feet
* Thanks to everyone ([Our Contributors](https://atlassianps.org/#people)) that helped with this module

## Useful links

* [Source Code]
* [Latest Release]
* [Submit an Issue]
* [Contributing]
* How you can help us: [List of Issues](https://github.com/AtlassianPS/JiraPS/issues?q=is%3Aissue+is%3Aopen+label%3Aup-for-grabs)

## Disclaimer

Hopefully this is obvious, but:

> This is an open source project (under the [MIT license]), and all contributors are volunteers. All commands are executed at your own risk. Please have good backups before you start, because you can delete a lot of stuff if you're not careful.

<!-- reference-style links -->
  [Source Code]: https://github.com/AtlassianPS/HipchatPS
  [Latest Release]: https://github.com/AtlassianPS/HipchatPS/releases/latest
  [Submit an Issue]: https://github.com/AtlassianPS/HipchatPS/issues/new
  [@markwragg]: https://github.com/markwragg
  [MIT license]: https://github.com/AtlassianPS/HipchatPS/blob/master/LICENSE
  [Contributing]: http://atlassianps.org/docs/Contributing

<!-- [//]: # (Sweet online markdown editor at http://dillinger.io) -->
<!-- [//]: # ("GitHub Flavored Markdown" https://help.github.com/articles/github-flavored-markdown/) -->
