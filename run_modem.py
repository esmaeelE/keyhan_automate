from send_sms import *
import json
import time


def handle_sms():
    modem=modem_init()
    # sleep one minute to ensure get new message
    delay_toget_sms(10)
    sms_message = get_sms(modem)
    return sms_message

def delay_toget_sms(second: int):
    time.sleep(second)

def modem_init():
    output = init_gsm_modem()
    modem = ''.join(output.decode('utf-8').split()[0].split('/')[-1])
    return modem

def get_sms(modem):

    if modem:

        bash_command = ['mmcli', '-m', f'{modem}', '--messaging-list-sms']
        ret=run_bash_command(bash_command)
        message_number = ''.join(ret.decode('utf-8').split()[0].split('/')[-1])
        # print(message_number)

        bash_command = ['mmcli', '-m', f'{modem}', '--sms', f'{message_number}', '-J']
        ret=run_bash_command(bash_command)


        # get dict
        data = json.loads(ret)
        # get only text
        message = data.get('sms').get('content').get('text')

        # print (message)
        return message