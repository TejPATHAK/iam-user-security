
# AWS IAM Security Automation Project

This project demonstrates secure AWS Identity and Access Management (IAM) configuration using AWS CLI. It involves creating IAM users, policies, enforcing MFA, and enabling AWS CloudTrail logging — all scripted and auditable. It is designed to simulate real-world DevSecOps automation for cloud identity and access control.

## Features Implemented

 1. Created custom IAM policy: `ReadOnlyS3EC2Policy`
 2. Created IAM group: `adminsGroup`
 3. Created IAM user: `projectAdminUser`
 4. Attached user to group with permissions
 5. Enabled login profile with strong password
 6. Enforced strong password policy across account
 7.  Enabled MFA (Multi-Factor Authentication)
 8. Created S3 bucket for CloudTrail logs
 9. Applied S3 bucket policy for CloudTrail access
 10. Created and started CloudTrail trail for auditing

## AWS Services Used

- AWS IAM (Identity and Access Management)
- AWS S3 (for storing CloudTrail logs)
- AWS CloudTrail (activity logging and auditing)
- AWS CLI (for automation via command-line)

## Project Folder Structure

```
iam-user-security-project/
├── readonly-policy.json # Custom IAM policy JSON
├── cli-commands.cmd # Windows CMD script to automate the setup
├── mfa-qr-code.png # QR code for virtual MFA device
├── README.md # Project documentation
```


## How to Run This Project
 Requires AWS CLI and credentials already configured (`aws configure`)

1. Clone/download the repo.
2. Open `cli-commands.cmd` in Command Prompt or VS Code terminal.
3. Run each command step-by-step OR run the script.
          OR
1. Open terminal (CMD or VS Code)
2. Run AWS CLI configuration: `aws configure`
3. Execute script: `cli-commands.cmd`
4. Scan the MFA QR code using Google Authenticator or similar app
5. Enter MFA codes when prompted
6. Verify user access, policy, and CloudTrail logging

## IAM Policy (readonly-policy.json)

Grants read-only access to all EC2 and S3 resources.

## 🎯 Learning Outcomes

- Automate IAM user and policy creation using AWS CLI
- Understand group-based permission architecture
- Implement security best practices like MFA and password policy
- Set up CloudTrail logging for traceability and auditing

- Bucket name: cloudtrail-logs-tejpathak-93127
- Key (folder path): AWSLogs/AWS Account Id/CloudTrail/us-east-1/2025/07/08/
- (https://s3.amazonaws.com/cloudtrail-logs-tejpathak-93127/AWSLogs/Your AWS-Account id/CloudTrail/us-east-1/2025/07/08/)
- (https://s3.console.aws.amazon.com/s3/buckets/cloudtrail-logs-tejpathak-93127?prefix=AWSLogs/AWS-Account id/CloudTrail/us-east-1/2025/07/08/&region=us-east-1)

##  Author

**Tejaswi Pathak**  
B.Tech Computer Science and Engineerig 
Passionate about Cloud, DevOps, Automation, and Security  

🔗 [LinkedIn](https://www.linkedin.com/in/tejaswi-pathak)  
📂 [GitHub](https://github.com/TejPATHAK/iam-user-security.git)
