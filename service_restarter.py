#just restarts the desired service

def main ():
    user_input = input("What service do you want to restart")
    os.system("nircmd.exe service restart", user_input)

main()
