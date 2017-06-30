$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $here
$moduleRoot = "$projectRoot\HipChatPS"

. "$moduleRoot\Public\Send-HipChat.ps1"

Describe 'Send-HipChat' {

    Mock Invoke-WebRequest { Import-Clixml "$here\Send-HipChat.invoke-webrequest.xml" }
    
    It "should return true" {

        $params = @{
            message = "Pester test message"
            room = "Test"
            apitoken = "c6cS2qXSv1zRyUUXpPsu3bebVF43wx8bvPQK5vg6"
        }

        Send-HipChat @params | Should Be $true
    }

    It "should reject the colour blue" {

        $params = @{
            message = "Pester test message"
            room = "Test"
            apitoken = "fakefalsetoken"
            color = "blue"
        }

        {send-hipchat @params} | Should Throw
    }
}


Describe "Send-HipChat timeouts" {
    
    Mock Invoke-WebRequest { Throw }

    It "should retry 3 additional times" {

        $params = @{
            message = "Pester test message"
            room = "Test"
            apitoken = "fakefalsetoken"
            retry = 3
            retrysecs = 1
            ErrorAction = "SilentlyContinue"
        }

        send-hipchat @params | Should be $false
        Assert-MockCalled Invoke-WebRequest -Exactly 4 -Scope It
        
    }

}
