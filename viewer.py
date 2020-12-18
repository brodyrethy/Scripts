import os, time, paramiko

#uses ssh key

#connect to server
#look for ~/file1, if exists, create ~/file2 and use as $userfile, etc... file1 is now $theirfile
#look for ~/file1, if exists, look for file2, if exists, look for file3, etc.
#subroutine is launched, which connects via ssh and monitors $their file for changes... 
    #each time there is a change, it is captured and appended to $their chat log ~/.local/share/ssh-chat/their.log and overwrites ~/.local/share/ssh-chat/all_history.log
#message is sent over SSH and overwrites $userfile

#TODO
#if no ssh key, exit

def main():
    if (check_for_config == False):
        chat_serv_ip_addr = input("Server IP address: ")
        chat_serv_username = input("Server SSH user: ")
        chat_serv_password = input("Server SSH user: ")
        make_configs(chat_serv_ip_addr, chat_serv_username)

    their_file = ""
    while True:
        ssh = paramiko.SSHClient()
        ssh.connect(chat_serv_ip_addr, username=chat_serv_username, password=chat_serv_password)
        ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("echo " + their_file)
        
        if (stdin != their_file):
            print(file_contents)
        time.sleep(1)

def check_for_config():
    if (os.path.isdir("~/.local/share/ssh_chat") and os.path.exists("~/.local/share/ssh_chat/chat_serv/chat_serv_ip_addr") and os.path.exists("~/.local/share/ssh_chat/chat_serv/chat_serv_username")):
        return true
    else:
        return false

def make_configs(chat_serv_ip_addr, chat_serv_username):
    os.system("echo '" + chat_serv_ip_addr + "' > ~/.local/share/chat_serv/chat_serv_ip_addr")
    os.system("echo '" + chat_serv_username + "' > ~/.local/share/chat_serv/chat_serv_username")

main()
