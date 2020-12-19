import os, time, paramiko

#look for ~/file1, if exists, create ~/file2 and use as $userfile, etc... file1 is now $theirfile
#look for ~/file1, if exists, look for file2, if exists, look for file3, etc.
#subroutine is launched, which connects via ssh and monitors $their file for changes... 
    #each time there is a change, it is captured and appended to $their chat log ~/.local/share/ssh-chat/their.log and overwrites ~/.local/share/ssh-chat/all_history.log
#message is sent over SSH and overwrites $userfile

#TODO
#if no ssh key, exit

def define_file():
    userfile = 0
    ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command('[ -f ' + theirfile + ' ] && echo "True" || echo "False"')
    if (bool(ssh_stdout) == False)
        return ssh_stdout

def get_theirfile_as_var(theirfile):
    ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command('echo ~/' + theirfile)
    return ssh_stdout

def connect_to_server(chat_serv_ip_addr, chat_serv_username, chat_serv_password):
    ssh = paramiko.SSHClient()
    ssh.connect(chat_serv_ip_addr, username=chat_serv_username, password=chat_serv_password)

def check_for_config():
    if (os.path.isdir("~/.local/share/ssh_chat") and os.path.exists("~/.local/share/ssh_chat/chat_serv/chat_serv_ip_addr") and os.path.exists("~/.local/share/ssh_chat/chat_serv/chat_serv_username")):
        return True
    else:
        return False

def make_configs(chat_serv_ip_addr, chat_serv_username):
    paths = ["chat_serv_ip_addr", "chat_serv_username"]

    for x in paths:
        f = open("~/.local/share/chat_serv/" + x, "w")
        f.write(x)
        f.close()

def main():
    theirfile = ""

    if (check_for_config() == False):
        chat_serv_ip_addr = input("Server IP address: ")
        chat_serv_username = input("Server SSH user: ")
    else:
        print("Server IP address and user saved")

    chat_serv_password = input("Server SSH password: ")

    make_configs(chat_serv_ip_addr, chat_serv_username)

    define_file()

    while True:
        connect_to_server(chat_serv_ip_addr, chat_serv_username, chat_serv_password)
        ssh_stdout = get_file(their_file)
        
        if (stdin != their_file):
            print(file_contents)
        time.sleep(1)

main()
