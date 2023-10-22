"""
Middle server that listen to receive data from jira server and
send sms to appropriate contact to inform him/her
created issues.
"""

from send_sms import init_gsm_modem
from flask import Flask, render_template, request
import run_modem

import logging
import logging.config

logger = logging.getLogger(__name__)

app = Flask(__name__)


# @app.route('/', methods=['POST', 'GET'])
@app.route('/')
def data():
    """run when an call from curl issued"""
    if request.method == 'GET':
        message = run_modem.handle_sms()
        send_to_server = message.split(':')[-1].strip()
        return send_to_server

    return False


# run a http server on this ip:port address
app.run(host='0.0.0.0', port=9090)
