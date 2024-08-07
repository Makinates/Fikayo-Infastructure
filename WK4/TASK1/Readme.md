### IMPLEMENTING TERRAFORM STATE MANAGEMENT USING TERRAFORM CLOUD

In order to save the terraform state files and have a ci/cd flow, I implemented the use of terraform cloud to give me a workflow. Below indicates the steps followed to use it:

- First step is to create a terraform cloud account.
- Then once logged in, create a Project in this case I called my project ***Makinates-Fikayo-infastructure-PROD***.
- Once that has been created, We will have to create a workspace and this will prompt for certain things such as:
    ![](./Assets/workspaces.png)
 For this project we will be using VCS(Version control workflow).
- This will prompt the connecting to a github account and repository which for this case is the Makinates-fikayo-infastructure.
- Once this has been fully created, a push to the githuub repository, triggers a run in terraform cloud but this can also be triggered manually in the terrfaorm cloud CLI e.g
   ![](./Assets/Runs.png)
- For my first push to github it resulted in a failed run why? This i sbecause my root folder has no ***main.tf*** file which will result in this:
    ![](./Assets/firstFail.png)
To fix this I had to specify my actual folder where the cloud should target
    ![](./Assets/firstfix.png)
- Now that the error was fixed I triggered a new ruun but that resulted in a fail also why? Because it requires the AWS credentials:
    ![](./Assets/Credentials.png)
In order to fix this I had to add variables in my terraform cloud variables settings
    ![](./Assets/CredentialsFix.png)
    ![](./Assets/VARAIBLES.png)
- Once that was included and oushed to the REPO, here was what the triggered run looked like:
    ![](./Assets/TRIGGEREDRUN.png)
- It planned everything but did not apply as thats the setting I have set up it will require a confirmation before apllying the changes to the AWS account:
    ![](./Assets/pendingapproval.png)
To change the setting to auto apply the changes, I can set it to auto-apply:
    ![](./Assets/autoapply.png)
- The apply shows you what resources were created and what resources failled to create and I can apply changes to create just those which failed:
    ![](./Assets/failedResources.png)
It uses the current state file and figures out what new changes were added and what resources were not created and uses that to apply fixes. So instead of recreating the entire infastructure, it creates only the failed resources or any other resource which were modified.
    ![](./Assets/FIXEDKEY.png)


I set up all the resources and then transferred my key to the public ec2 instance using 
```
 scp -i "D:\\Documents\\Documents\\Fikayo-Infastructure\\WK4\\TASK1\\Fikayo-keyPair1.pem" "D:\\Documents\\Documents\\Fikayo-Infastructure\\WK4\\TASK1\\Fikayo-keyPair1.pem" ec2-user@35.172.103.124:/home/ec2-user/Fikayo-keyPair1.pem
```

Once the key was transferred, I SSH'ed into the private Ec2 instance 