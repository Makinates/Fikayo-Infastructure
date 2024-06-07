#!/usr/bin/env python3

import os
import subprocess

folder_path = os.path.abspath("../")
print("Root directory:", folder_path)

def Testing_commands(item):
    Read_path = os.path.join(os.path.abspath(os.path.join("..", item)),"Readme.md")

    if os.path.exists(Read_path):
        grep_command = ["grep", "Fikayo Oluwakeye", Read_path]

        try:
            grep_output = subprocess.check_output(grep_command, stderr=subprocess.STDOUT)
            # Decode the output from bytes to string
            grep_output = grep_output.decode("utf-8")

            # Print the grep output
            print(grep_output)
        except subprocess.CalledProcessError as e:
            if e.returncode == 1:
                awk_command = f'echo "Fikayo Oluwakeye" >> "{Read_path}"'
                subprocess.run(awk_command, shell=True)
            else:
                print(f"Error: {e}")
    else:
        print(f"Readme.md file not found in {Read_path}")


    

def check_readme(folder):
    has_readme = False
    new_path= os.path.abspath(os.path.join("..", folder))
    print(new_path)
    for item in os.listdir(new_path):
        filename, file_extension = os.path.splitext(item)
        # Check if the filename is "README" and the extension is ".md"
        if filename.lower() == "readme" and file_extension == ".md":
            print("Has A README")
            has_readme = True
            break
        else:
            print("No ReadMe Detected")
    

    if has_readme == False:
        #Create a readme in the folder 
        read_me_path = os.path.join(new_path,"ReadMe.md")
        with open(read_me_path, "w") as readme_file:
            readme_file.write("# Welcome to the folder\n\nThis folder is created by the script.")
    


print("\nFiles in the root directory:")
for item in os.listdir(folder_path):
    check_readme(item)
    Testing_commands(item)


