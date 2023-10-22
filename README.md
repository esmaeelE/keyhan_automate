# Automate Dongle for MCI keyhan client

* listen server if triggred get sms message and push to client

* ensure work?

* ```mmcli --modem 13 --messaging-list-sms | head -n1```

* ```mmcli -m 13 --sms 7```

* ```mmcli -m 13 --sms 7 -J ```


# Install 

    python3 -m venv env
    source env/bin/activate
    python3 -m pip install flask

# Run

    python3 server.py

# client side 

Place ***keyhan.ps1*** to MCI machine and run it to get sms automatically.
