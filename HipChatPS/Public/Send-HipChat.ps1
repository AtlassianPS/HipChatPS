function Send-HipChat {
<#
.SYNOPSIS
    Sends messages to a Hipchat room.
.DESCRIPTION
    Send-HipChat can be used within a script or at the console to send a message to a HipChat room.
.EXAMPLE
    Send-Hipchat -Message 'Hello' -Color 'Green' -Notify -ApiToken myapitoken -Room MyRoom -Retry 5 -RetrySec 10

    This sends a message of 'Hello' highlighted green in to a room named MyRoom. Users in the room will be notified
    in their clients that a new message has been recevied. If it cannot successfully send the message it will retry
    5 times, at 10 second intervals.
#>
    [CmdletBinding()]
    [OutputType([Boolean])]
	Param(
        #Required. The message body. 10,000 characters max.
        [Parameter(Mandatory = $True)]
        [string]$message,

        #The background colour of the HipChat message. One of "yellow", "green", "red", "purple", "gray", or "random". (default: gray)
        [ValidateSet('yellow', 'green', 'red', 'purple', 'gray','random')]
        [string]$color = 'gray',

        #Set whether or not this message should trigger a notification for people in the room. (default: false)
        [switch]$notify,

        #HipChat API endpoint (default: https://api.hipchat.com)
        [string]$uri = 'https://api.hipchat.com',

        #Required. This must be a HipChat API token created by a Room Admin for the room you are sending notifications to.
        [Parameter(Mandatory = $True)]
        [string]$apitoken,

        #Required. The id or URL encoded name of the HipChat room you want to send the message to.
        [Parameter(Mandatory = $True)]
        [string]$room,

        #The number of times to retry sending the message (default: 0)
        [int]$retry = 0,

        #The number of seconds to wait between tries (default: 30)
        [int]$retrysecs = 30
    )

    $messageObj = @{
        "message" = $message
        "color" = $color
        "notify" = [string]$notify
    }

    $uri = "$uri/v2/room/$room/notification?auth_token=$apitoken"
    $Body = ConvertTo-Json $messageObj
    $Post = [System.Text.Encoding]::UTF8.GetBytes($Body)

    $Retrycount = 0

    While($RetryCount -le $retry){
	    try {
            if ($PSVersionTable.PSVersion.Major -gt 2 ){
                $Response = Invoke-WebRequest -Method Post -Uri $uri -Body $Body -ContentType "application/json" -ErrorAction SilentlyContinue
            }else{
                $Request = [System.Net.WebRequest]::Create($uri)
                $Request.ContentType = "application/json"
                $Request.ContentLength = $Post.Length
                $Request.Method = "POST"

                $requestStream = $Request.GetRequestStream()
                $requestStream.Write($Post, 0,$Post.length)
                $requestStream.Close()

                $Response = $Request.GetResponse()

                $stream = New-Object IO.StreamReader($Response.GetResponseStream(), $Response.ContentEncoding)
                $stream.ReadToEnd() | Out-Null
                $stream.Close()
                $Response.Close()
            }
            Write-Verbose "'$message' sent!"
            Return $true

        } catch {
            Write-Error "Could not send message: `r`n $_.Exception.ToString()"

             If ($retrycount -lt $retry){
                Write-Verbose "retrying in $retrysecs seconds..."
                Start-Sleep -Seconds $retrysecs
            }
        }
        $Retrycount++
    }

    Write-Verbose "Could not send after $Retrycount tries. I quit."
    Return $false
}
