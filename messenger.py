import os, time

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
    if (check_for_config() == False):
        print("No existing configuration found...")
        chat_serv_ip_addr = input("Server IP address: ")
        if (not chat_serv_ip_addr):
            print("No entry: Quitting...")
            quit()
        chat_serv_username = input("Server SSH user: ")
        if (not chat_serv_username):
            print("No entry: Quitting...")
            quit()
        make_configs(chat_serv_ip_addr, chat_serv_username)

    while True:
        message = input("(> ")
        #login to ssh server, overwrite $userfile

def check_for_config():
    if (os.path.isdir("~/.local/share/ssh_chat") and os.path.exists("~/.local/share/ssh_chat/chat_serv/chat_serv_ip_addr") and os.path.exists("~/.local/share/ssh_chat/chat_serv/chat_serv_username")):
        return True
    else:
        return False

def make_configs(chat_serv_ip_addr, chat_serv_username):
    os.system("echo '" + chat_serv_ip_addr + "' > ~/.local/share/chat_serv/chat_serv_ip_addr")
    os.system("echo '" + chat_serv_username + "' > ~/.local/share/chat_serv/chat_serv_username")

main()
