# Function to connect vpn

Function Kill_keyhan($proces){
	$run = Get-Process $proces -ErrorAction SilentlyContinue
	if ($run) {
		# try gracefully first
		$run.CloseMainWindow()
		# kill after five seconds
		Sleep 5
		if (!$run.HasExited) {
			$run | Stop-Process -Force
		}
		Sleep 5
	}
    Remove-Variable run
}


Function check_connection(){
    
    ping 192.168.255.40 | Out-Null

    If ($LASTEXITCODE -ne 0) {
        echo "disconnect"
        return 0
    }
    Else {
        echo "connected"
        return 1
    }

}


Function Get_code(){
	# read message from web server 
    $response = Invoke-WebRequest '192.168.5.65:9090' | Select-Object -Expand Content
    # echo $response
    return $response
}



Function Connect-Keyhan(){

    # stop existing process
    #Stop-Process -Name "Client"
    Kill_Keyhan("Client")
    # Start a keyhan
    $ps = Start-Process -PassThru -FilePath "C:\Program Files (x86)\PayamPardaz\Keyhan\Client.exe" -WindowStyle "Normal"
	
    # Creating WScript.Shell instance
    $wshell = New-Object -ComObject wscript.shell
	
    # Wait until activating the target process succeeds.
    # Note: You may want to implement a timeout here.
    while (-not $wshell.AppActivate($ps.Id)) { 
      # Waiting for app to start....
      Start-Sleep -MilliSeconds 5000
    }
    sleep 2
	
    $wshell.SendKeys('keya')
    $wshell.SendKeys('{ENTER}')
    Sleep 5

    $code = Get_code
    $wshell.SendKeys($code)
    $wshell.SendKeys('{ENTER}')
    
}

# Connect-Keyhan
$ret=check_connection

If ($ret -ne 0) {
    echo "disconnect"
    Connect-Keyhan
}

