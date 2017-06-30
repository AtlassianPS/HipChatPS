# Powershell Commands for HipChat

A module for PowerShell with functions for interacting with the team chat tool "Hipchat" by Atlassian. The module utilises Hipchat API v2: https://www.hipchat.com/docs/apiv2.

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
