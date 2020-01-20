# Day 1

### Module 1: Introduction
Here is a chart with the different services and what region they are available in.
https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/
 
Here is an overview of our infrastructure: https://infrastructure.aws/

### Module 2: The Simplest Architecture

S3 bucket URLs and the different formats
http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro
 
Multipart upload - https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html
Amazon S3 Multipart Upload Limits
 

Vault Lock Policies in Glacier:
https://docs.aws.amazon.com/amazonglacier/latest/dev/vault-lock-policy.html
 
Storage Gateway and the options inside including the “Tape Gateway” Virtual Tape Library and compatibility:
https://docs.aws.amazon.com/storagegateway/latest/userguide/create-gateways.html
 
 Hardware Storage Gateway Details
https://aws.amazon.com/about-aws/whats-new/2018/09/aws-storage-gateway-is-now-available-as-a-hardware-appliance/
 
You can connect from your VPC to S3 using the VPC endpoint. You can find more information about 'Working with Endpoints' on this link:
http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html#working-with-vpc-endpoints
 
### Module 3: Adding a Compute Layer

SSD, and HDD:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ssd-instance-store.html
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html

 
EC2 Instances information and comparison- capabilities and features:
http://www.ec2instances.info
 
The update to Spot Instances that allow Stop instead of Terminate:
https://aws.amazon.com/blogs/aws/new-stop-resume-workloads-on-ec2-spot-instances/
 
Further update to Spot Instances that allow Hibernate (just released at re:Invent)
https://aws.amazon.com/about-aws/whats-new/2017/11/amazon-ec2-spot-lets-you-pause-and-resume-your-workloads/
 
 
### Module 4: Adding a Database Layer

DynamoDB
https://aws.amazon.com/dynamodb/getting-started/
https://aws.amazon.com/getting-started/tutorials/create-nosql-table/
 
Global Tables. What do global tables look like?
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables_HowItWorks.html
 
Cache for Dynamo DB
https://aws.amazon.com/dynamodb/dax/
 
Best practice for DynamoDB:
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html
 

### Lab 1: Deploying a Web Application on AWS
- Building a 3 tier web app in AWS 
https://media.amazonwebservices.com/architecturecenter/AWS_ac_ra_web_01.pdf
 
### Module 5: Networking in AWS Part 1

Subnetting secret book:
https://www.amazon.com/gp/product/B07KV7N8WS/ref=dbs_a_def_rwt_bibl_vppi_i5
 
DNS in VPC:
https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html
  
Direct connect information:
https://docs.aws.amazon.com/directconnect/latest/UserGuide/Welcome.html
 
HA with on prem and AWS:
https://aws.amazon.com/answers/networking/aws-multiple-data-center-ha-network-connectivity/
 
Handy Tool – http://CIDR.xyz

Info about VPC Peering and encryption:
Importantly, intra-region peering is not encrypted, but inter-region peering is encrypted:
https://aws.amazon.com/vpc/faqs/#Peering_Connections
 
VPC Peering across regions (released at re:Invent 2017)
https://aws.amazon.com/about-aws/whats-new/2017/11/announcing-support-for-inter-region-vpc-peering/
  
Day In The Life of a Billion Packets (3rd revision of this talk)
https://youtu.be/St3SE4LWhKo
 
 
### Lab 2: Creating a Virtual Private Cloud

- Building a VPC – getting started
https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-ipv4.html
 
> ####  Additional Resources and Reading
The following will provide information on the terms used in AWS:
https://docs.aws.amazon.com/general/latest/gr/glos-chap.html
 
> ##### Icon sets
https://aws.amazon.com/architecture/icons/
 
> ##### re:Invent Videos
https://reinventvideos.com/
 
> ##### AWS Blog
This is a great place to see what’s new at AWS. It is constantly being updated as new features are rolled out. https://aws.amazon.com/blogs/aws/
 

> ##### Architecture icons and drawing tools are available here from AWS:
https://aws.amazon.com/architecture/icons/
 
> ##### Important “memorized” URLs from AWS:
Pricing - https://aws.amazon.com/pricing/
Documentation - https://aws.amazon.com/
Answers - https://aws.amazon.com/answers/
Compliance - https://aws.amazon.com/compliance/
Whitepapers - https://aws.amazon.com/whitepapers/
 
##### Services finder – in what regions are specific services available?
https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/
 
##### AWS Service limits – many of which are soft limits and can be increased:
http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html

# Day 2

#### Module 6: Networking in AWS Part 2

Info about the Transit VPC solution – useful if VPC Peering will not work (due to overlapping CIDR ranges) or if you want to do fancier routing or traffic inspection
https://aws.amazon.com/answers/networking/aws-global-transit-network/
 

#### Module 7: AWS Identity and Access Management

Rotating IAM access keys
https://aws.amazon.com/blogs/security/how-to-rotate-access-keys-for-iam-users/
This is a great link with a tutorial on how to rotate your IAM access keys.
 
Deep Dive to IAM policies from re:Invent 2016 (How to be an IAM Policy Ninja in 60 minutes or less):
https://youtu.be/y7-fAT3z8Lo
   
A deeper dive into the different policies that can be created in IAM – including resource level policies and the SCPs (Service Control Policies) introduced in Organizations
https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
 
The “What’s New” page at Amazon
https://aws.amazon.com/new/
 
MFA options:
https://aws.amazon.com/blogs/mobile/amazon-cognito-user-pools-supports-federation-with-saml/
 
#### Module 8: Elasticity, High Availability and Monitoring

SCALABILITY:
What happens when AutoScaling policies conflict? From the documentation:
“A scale-in activity can't start while a scale-out activity is in progress.”
http://docs.aws.amazon.com/autoscaling/latest/userguide/as-scaling-simple-step.html
 
Autoscaling termination policy – tries to balance the AZs then by oldest launch configuration then by closest to hour then random
http://docs.aws.amazon.com/autoscaling/latest/userguide/as-instance-termination.html
 
“AWS Autoscaling Best Practices for Startups” – 3rd party blog about AWS AutoScaling
http://www.langton.cloud/aws-autoscaling-best-practices-for-startups/
 
CloudWatch metrics over all the services – what’s included:
http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CW_Support_For_AWS.html
 
Cloudwatch Log retention is infinite! But you can set it shorter… because of course infinity isn’t free
http://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/SettingLogRetention.html
 
Cloudwatch pricing
https://aws.amazon.com/cloudwatch/pricing/
 
User Input Transformer to Customize What is Passed to the Event Target
https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatch-Events-Input-Transformer-Tutorial.html
 
AutoScaling does create CloudWatch Events for scaling:
https://docs.aws.amazon.com/autoscaling/ec2/userguide/cloud-watch-events.html
 
The blog entry for DynamoDB AutoScaling:
https://aws.amazon.com/blogs/aws/new-auto-scaling-for-amazon-dynamodb/
 
DynamoDB SDKs have retry logic built in during throttles:
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html#Programming.Errors.RetryAndBackoff
 
Details on the Lambda concurrency limits can be set per function:
https://docs.aws.amazon.com/lambda/latest/dg/concurrent-executions.html
 

#### Lab 3: Creating a Highly Available Environment

- Here you can find some good templates to try out on your own.
https://aws.amazon.com/architecture/
 
#### Module 9: Automation

CloudWatch Agent surfaces a lot of information from an EC2 instance
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-Configuration-File-Details.html
All those metrics can be used to make CloudWatch Alarms for scaling or notifications
 
More about AWS OpsWorks (managed Chef or Puppet) specifically about Chef which sounds like it’s been used in your environment.
https://aws.amazon.com/opsworks/chefautomate/
 
Lambda Execution environment under the covers
http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html
 
Lambda Trigger Event sources and sample events for each source:
https://docs.aws.amazon.com/lambda/latest/dg/invoking-lambda-function.html
 
An AWS Serverless Web App tutorial
https://aws.amazon.com/serverless/build-a-web-app/
 
AWS Serverless Application Repository – prebuilt serverless apps featuring API Gateway and Lambda
https://aws.amazon.com/serverless/serverlessrepo/
 
DESIGNING AT WEB SCALE:
Header forwarding in CloudFront – there was a question about what the origin sees as the client – it will see Cloudfront as the originator but it will forward along the X-Forwarded-For header among others:
https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/RequestAndResponseBehavior.html
 
A free qwiklab introducing Lambda
https://qwiklab.com/focuses/2966
 
Limits specific to CloudFormation:
https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html
 
CloudFormer – AWS tool for creating a cloudformation template from a running environment
http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-using-cloudformer.html
 
hava.io – a 3rd party tool that can create diagrams and cloudformation templates
http://hava.io/
 
CloudCraft.co – 3rd-party tool for creating AWS diagrams
http://cloudcraft.co/
 
LucidChart AWS Architecture import – 3rd-party tool for creating diagrams from existing infrastructure
https://www.lucidchart.com/pages/aws-architecture-import
 
CloudFormation cross-stack references walkthrough from AWS Documentation
http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-crossstackref.html
 
CloudFormation and Wait Conditions and Wait Handles
https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-waitcondition.html
 
Setting up the EC2 Run Command (and Systems Manager in general) – agent installation and internet connectivity requirements
http://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-setting-up.html
 
The new AWS Systems Manager which includes EC2 Systems Manager tools and more
https://aws.amazon.com/systems-manager/
 
 
Lab 4: Automating Infrastructure Deployment with AWS CloudFormation

There are a few good links above to use for reference when using Cloud Formation.
 
 
Additional Information:

The Cloud Economics page – including tools to calculate TCO and impact of migrating to AWS; we’ll talk more tomorrow about Cost Optimization also.
https://aws.amazon.com/economics/
Also be sure to look at the related whitepapers:
https://aws.amazon.com/whitepapers/#cloud-computing-economics
 
 AWS Service Limits – many of which are soft!
https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html
 
The page for Aurora, the Amazon-created flavor of RDS. Pay attention to Multi Master and Serverless features
https://aws.amazon.com/rds/aurora/
 
Speaking of Multi-Master, DynamoDB introduced Global tables which is like having multi-master DynamoDB cross-region
https://aws.amazon.com/dynamodb/global-tables/
 
DynamoDB Global tables – especially pay attention to best practices!
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables_HowItWorks.html
 
The best DynamoDB reference is a talk by one of the engineers at MIT (2 hours!)
https://youtu.be/FNFRTnp9Qh4
 
DynamoDB Course from AWS on EdX
https://www.edx.org/course/amazon-dynamodb-building-nosql-database-driven-app
 
A deep dive into the idea of Eventual Consistency by Werner “Everything Fails All The Time” Vogels: Amazon’s CTO:
https://www.allthingsdistributed.com/2007/12/eventually_consistent.html
 
Bonus: Werner Vogels’s website is hosted out of S3 via a serverless static blogging framework called Jekyll:
https://jekyllrb.com/
 
Announcement and form to request access to the new managed graph data service Amazon Neptune
https://aws.amazon.com/about-aws/whats-new/2017/11/amazon-neptune-fast-reliable-graph-database-built-for-the-cloud/
 
AWS S3 Transfer Acceleration using Edge Locations
https://aws.amazon.com/blogs/aws/aws-storage-update-amazon-s3-transfer-acceleration-larger-snowballs-in-more-regions/
 
NEW: S3 Increased Performance:
https://aws.amazon.com/about-aws/whats-new/2018/07/amazon-s3-announces-increased-request-rate-performance/
 
S3 and avoiding hot partitions (deprecated, but here for reference)
http://docs.aws.amazon.com/AmazonS3/latest/dev/request-rate-perf-considerations.html
 
In depth 3rd party blog about hot partitions and the very, very high requests rates achievable with S3 (again, deprecated)
https://medium.com/@pollett/aws-s3-at-speed-898f4bab9c2
 
Code Spaces gets hacked
https://threatpost.com/hacker-puts-hosting-service-code-spaces-out-of-business/106761/
 
Don’t put your keys in a public repository ….
https://www.zdnet.com/article/over-100000-github-repos-have-leaked-api-or-cryptographic-keys/
 
 
 Route 53 Websocket - https://aws.amazon.com/about-aws/whats-new/2018/11/amazon-cloudfront-announces-support-for-the-websocket-protocol/
 
Elasticache info:
            https://d0.awsstatic.com/whitepapers/performance-at-scale-with-amazon-elasticache.pdf
 
Feedback for AWS on services 
             https://aws.amazon.com/premiumsupport/knowledge-center/send-feedback-aws/
 
 

 
# Day 3

 
 
#### Module 10: Caching

What is caching and how does it work?
https://aws.amazon.com/caching/
 
DAX
https://aws.amazon.com/dynamodb/dax/
 
DynamoDB Accelerator (DAX) is an in-memory cache specifically for DynamoDB reducing response times to the microseconds
https://aws.amazon.com/dynamodb/faqs/#dax
 
Elasticache
https://aws.amazon.com/elasticache/
 
#### Module 11: Building Decoupled Architectures

Here is the video about API gateway –
https://www.youtube.com/watch?v=xkDcBssNd1g
 
#### Module 12: Microservices and Serverless Architectures

AWS WAF and Shield – Shield Standard is the built-in protections for DDoS. Shield Advanced is the paid tier with extra options including live response teams
http://docs.aws.amazon.com/waf/latest/developerguide/what-is-aws-waf.html
 
AWS WAF leverages CloudWatch for its logging and metrics (from the WAF documentation)
https://docs.aws.amazon.com/waf/latest/developerguide/monitoring_overview.html
 
Lambda examples:
https://docs.aws.amazon.com/lambda/latest/dg/use-cases.html
 
Lambda Optimization - This AWS documentation provides some best practices for writing your function.
http://docs.aws.amazon.com/lambda/latest/dg/best-practices.html
 
 
 #### Lab 5: Implementing a Serverless Architecture with AWS Managed Services

Lambda / Polly Demo 
Instructions:  https://aws.amazon.com/blogs/machine-learning/build-your-own-text-to-speech-applications-with-amazon-polly/
 
Using Lambda with Kinesis – tutorial
http://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html
 
AWS Kinesis example from MLBAM (Major League Baseball Advanced Media)
https://youtu.be/Nk1jJ0kNbqU
 
 
#### Module 13: RTO/RPO and Backup Recovery Setup

White Paper on RTO and RPO
https://aws.amazon.com/blogs/aws/new-whitepaper-use-aws-for-disaster-recovery/
 
Large Scale Recovery
https://aws.amazon.com/blogs/startups/large-scale-disaster-recovery-using-aws-regions/
 
Disaster Recovery options (video)
https://www.youtube.com/watch?v=2Bkt7MssTlE
 
Copying snapshots and specifically around what you need to do if you are going across regions – you have to specify the Master Keys in the source region and the destination region for encryption at rest, and it is encrypted in transit with AES-256 automatically. 
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-copy-snapshot.html
 
 
#### Module 14: Optimizations and Review

Continuous optimization
https://aws.amazon.com/blogs/enterprise-strategy/continuous-optimization/
 
> Additional Items:

>Here is a link for videos in case you need to remember from the labs:
Architecting on AWS - http://bit.ly/arclabs

> Certificate Authority information -  
https://aws.amazon.com/blogs/aws/aws-certificate-manager-launches-private-certificate-authority/
 
> Netflix’s Simian Army
https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116
 
> Conformity Monkey for watching configurations
https://medium.com/netflix-techblog/conformity-monkey-keeping-your-cloud-instances-following-best-practices-2aaff3479adc
 
> Cloud Custodian – similar tool made by Capital One’s team and published to Github
https://github.com/capitalone/cloud-custodian
 
> Active Directory Connector –
https://docs.aws.amazon.com/directoryservice/latest/admin-guide/directory_ad_connector.html

> Info about WAF – is leverages CloudWatch for logging and visibility into attacks
https://aws.amazon.com/waf/details/
 
> A 3rd party tool for creating visualizations of Security Groups
https://github.com/anaynayak/aws-security-viz
 
> GuardDuty pricing is based on volume of logs ingested – CloudTrail, VPC Flow Logs, and DNS Query logs
https://aws.amazon.com/guardduty/pricing/
 
> Instance Metadata: 
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html
 
> S3 server-side encryption with customer provided keys:
https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html
 
> A video from our Youtube channel regarding our philosophies with distributed systems and maintaining them
https://www.youtube.com/watch?v=QVvFVwyElLY
 
> Amazon did put up the docs on how they arrived at the benchmarks for if you want to replicate it.
For Aurora vs. MySql
https://d1.awsstatic.com/product-marketing/Aurora/RDS_Aurora_Performance_Assessment_Benchmarking_v1-2.pdf
 
> For Aurora vs. Postgres
https://d1.awsstatic.com/product-marketing/Aurora/RDS_Aurora_PostgreSQL_Performance_Assessment_Benchmarking_V1-0.pdf

> DynamoDB now has point-in-time restore backups to S3
https://aws.amazon.com/dynamodb/backup-restore/
   
> You can rotate the master keys in KMS automatically on an annual basis or manually whenever you choose:
https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html
 
> The new AWS Single Sign On Service to simplify that process and integrate with Organizations
https://aws.amazon.com/single-sign-on/
 
> The new highly available CloudHSM announcement:
https://aws.amazon.com/about-aws/whats-new/2017/08/announcing-the-new-aws-cloudhsm-offering-cost-effective-hardware-key-management-at-cloud-scale-for-sensitive-and-regulated-workloads/
 
> The AWS Blog, specifically all the items regarding cost reductions – 66 in AWS history!
https://aws.amazon.com/blogs/aws/category/price-reduction/
 
> A fun (and free) troubleshooting qwiklab that I found interesting at the latest re:Invent where you troubleshoot and fix a VPC
https://qwiklab.com/focuses/3125?locale=en
 
## Exam Tips:

The main thing for the AWS SAA certification is understanding what the service does. Reading the FAQ for the services and also reading this whitepaper.

Building a LAMP stack on AWS

There are five pillars in the Well Architected Framework there are tradeoffs depending on implementation. 

These are questions asked to know if you are following best practices in AWS. (Recommended reading if going for AWS Certified Solutions Architect - Associate )

Need ideas or a starting point on build out take a look at our AWS Architecture references.

The Certification Preparation resources:
https://aws.amazon.com/certification/certification-prep/
 
Solutions Architect Associate exam blueprint
https://d1.awsstatic.com/training-and-certification/docs-sa-assoc/AWS_Certified_Solutions_Architect_Associate_Feb_2018_%20Exam_Guide_v1.5.2.pdf
 
 The qwiklab quest for certification prep – note: some of these labs are free and some have a cost in “credits”
https://qwiklab.com/quests/10?locale=en
