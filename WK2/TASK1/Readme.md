### SETTING UP CI/CD PIPELINE USING GITHUB ACTIONS 

There are various methods to set up a ci/cd pipeline using github actions.
- By including the secret keys of AWS account in the github secrets.
- Assuming a role in AWS (more secure)

I went by step 2 in order to learn more about roles in AWS and below are the steps to authenticate to my AWS account.

### Authenticating to AWS 

- First step was to create an **identity provider** in AWS. What is an identity provider?  [Identity Providers](https://www.okta.com/identity-101/why-your-company-needs-an-identity-provider/). AWS has two provider type: SAML and OpenID.

![OpenID Connect](./Assets/OpeniId.png)


- Created a bucket to store my terraform state files.

- Then I created a custoim trust policy which is the role the user will assume when they sign in using their github credentials.

![Custom Trust Policy](./Assets/TrustPolicy.png)
![Permissions](./Assets/permissions.png)
![Permissions Detail](./Assets/PermissionsDetails.png)


### Adding Secrets to Github

![GITHUB Secrets](./Assets/GithubSecrets.png)

![Added Secrets](./Assets/SecrestAdded.png)



### How to create github workflow

In order to create the workflow, we have to create a special directory for the yml file as this is where github will pull from. The folder structure looks like this ***.github/workflows/*.yml**

After the Yml file was created I moved the folder to the root directory 