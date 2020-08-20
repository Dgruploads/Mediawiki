STEPS FOR DEPLOYING THE APPLICATION ON AWS.

    • Execute the CloudFormation template that will create an EC2 instance and a RDS DB Server.
    • Template is present in the zip file (Mediawiki.yaml). 
    • Below is the architecture that will help us to deploy the Mediawiki application and create Mysql database running in a RDS server.
    
![alt text](https://raw.githubusercontent.com/Dgruploads/Mediawiki/master/Mediawiki+db.png)



























    • There are 3 scripts that makes up for the deployment automation on AWS.
        ◦ CloudFormation Template will create the EC2 instance and RDS server (Mediawiki.yaml).
        ◦ Shell script to install the required packages and requisited to bring up Mediawiki (server.sh).
        ◦ Mysql script to create a user in the Mysql RDS server (mysql.sql).
      
    • Template will create the infrastrucure on AWS (EC2 and RDS).
    • Next, server.sh script will be executed as a boot up script in the template.
    • Next, mysql.sql script will be executed that will create a user in database.

Once the deployment is completed, we should be able to access the Mediawiki application using the below URL.
    • http://server-ip-address/mediawiki
    • Follow the steps on the screen. You will be asked to provide the DB details. DB endpoint will be available in the RDS console or we can get it from the EC2 server.
    • All the scripts are tested and they are working as expected.


STEPS TO SCALE THE APPLICATION ON AWS.

    • To Scale the application on AWS, we can make use of Auto Scaling feature that will help us to launch or terminate the instances depending on the load on the server, like increased CPU utilization or decreased CPU utilization.

      
    • For this purpose we will create a launch configuration, which is the template for the servers that will be created by the auto scaling group.
    • In the Auto scaling group we will specify the desired number of instances, minimum number of instances and maximum number of instances.
    • We will also create a scaling policy with a CloudWatch alarm that will monitor the metrics (For example CPU utilization with a threshold).
    • When the metric is above the threshold, the alarm will be triggered and will take an action (Increase the number of instance).
    • A sample template for the auto scaling has been attached in the zip file for reference.

