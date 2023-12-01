### Create and Attach IAM Role

1. Go to the IAM console and create a new role with the `AmazonEC2RoleforSSM` and `CloudWatchAgentServerPolicy` policies.
2. Attach this role to your EC2 instance.

```markdown
# CloudWatch Agent Setup and Management on EC2

This README provides instructions for setting up and managing the CloudWatch Agent on an Amazon EC2 instance.

## Setup

### Install the CloudWatch Agent

1. Connect to your EC2 instance.
2. Execute the following commands to download and install the CloudWatch Agent:

   ```bash
   wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
   unzip AmazonCloudWatchAgent.zip
   sudo ./install.sh
   ```

### Configure the Agent

1. Create a configuration file named `cloudwatch-agent-config.json`.
2. Use the provided configuration or customize as needed.

### Sample

```json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/secure", #This needs to be changed to the path of the log file you want to monitor
            "log_group_name": "login-monitoring",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
```


### Start the CloudWatch Agent

1. Start the agent using the following command:

   ```bash
   sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:cloudwatch-agent-config.json -s
   ```

2. Verify the agent is running:

   ```bash
   sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status
   ```

## Managing the CloudWatch Agent

### Starting the Agent

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/path/to/your/config.json -s
```

### Stopping the Agent

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a stop
```

## Navigate to Cloudwatch log group to check if you are able to check all the logs