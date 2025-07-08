@echo off
echo ===========================
echo AWS IAM Security Setup Script
echo Created by Tejaswi Pathak
echo ===========================

REM Step 1: Create a custom IAM policy
echo Creating IAM policy...
aws iam create-policy --policy-name ReadOnlyS3EC2Policy --policy-document file://readonly-policy.json

REM Step 2: Create IAM group
echo Creating IAM group...
aws iam create-group --group-name adminsGroup

REM Step 3: Attach policy to group (replace ACCOUNT_ID with actual account ID if needed)
FOR /F %%i IN ('aws sts get-caller-identity --query Account --output text') DO SET ACCOUNT_ID=%%i
aws iam attach-group-policy --group-name adminsGroup --policy-arn arn:aws:iam::%ACCOUNT_ID%:policy/ReadOnlyS3EC2Policy

REM Step 4: Create IAM user
echo Creating IAM user...
aws iam create-user --user-name projectAdminUser

REM Step 5: Create login profile
echo Creating login profile...
aws iam create-login-profile --user-name projectAdminUser --password "StrongPassw0rd!" --password-reset-required

REM Step 6: Add user to group
echo Adding user to group...
aws iam add-user-to-group --user-name projectAdminUser --group-name adminsGroup

REM Step 7: Create virtual MFA device (QR code image)
echo Creating virtual MFA device...
aws iam create-virtual-mfa-device --virtual-mfa-device-name projectAdminUser-mfa --outfile mfa-qr-code.png --bootstrap-method QRCodePNG

echo ==========  ACTION REQUIRED ==========
echo Open the file mfa-qr-code.png and scan it using Google Authenticator or Authy.
echo Then enter two consecutive MFA codes in the next command.
pause

REM Step 8: Enable MFA for the user (replace codes below with your actual codes at runtime)
echo Enabling MFA device...
aws iam enable-mfa-device --user-name projectAdminUser --serial-number arn:aws:iam::%ACCOUNT_ID%:mfa/projectAdminUser-mfa --authentication-code1 000000 --authentication-code2 111111

REM Step 9: Update account password policy
echo Setting account password policy...
aws iam update-account-password-policy --minimum-password-length 12 --require-symbols --require-numbers --require-uppercase-characters --require-lowercase-characters --allow-users-to-change-password --max-password-age 90 --password-reuse-prevention 5

REM Step 10: Create S3 bucket for CloudTrail logs
echo Creating S3 bucket...
aws s3api create-bucket --bucket cloudtrail-logs-tejpathak-93127 --region us-east-1

REM Step 11: Set S3 bucket policy to allow CloudTrail
echo Applying S3 bucket policy for CloudTrail...
aws s3api put-bucket-policy --bucket cloudtrail-logs-tejpathak-93127 --policy "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"AWSCloudTrailAclCheck\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"cloudtrail.amazonaws.com\"},\"Action\":\"s3:GetBucketAcl\",\"Resource\":\"arn:aws:s3:::cloudtrail-logs-tejpathak-93127\"},{\"Sid\":\"AWSCloudTrailWrite\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"cloudtrail.amazonaws.com\"},\"Action\":\"s3:PutObject\",\"Resource\":\"arn:aws:s3:::cloudtrail-logs-tejpathak-93127/AWSLogs/%ACCOUNT_ID%/*\",\"Condition\":{\"StringEquals\":{\"s3:x-amz-acl\":\"bucket-owner-full-control\"}}}]}"

REM Step 12: Create CloudTrail trail
echo Creating CloudTrail trail...
aws cloudtrail create-trail --name IAMSecurityTrail --s3-bucket-name cloudtrail-logs-tejpathak-93127 --is-multi-region-trail

REM Step 13: Start logging
echo Starting CloudTrail logging...
aws cloudtrail start-logging --name IAMSecurityTrail

echo ===========================
echo  All steps completed successfully!
echo CloudTrail logs will appear in: cloudtrail-logs-tejpathak-93127/AWSLogs/%ACCOUNT_ID%
echo ===========================
pause
