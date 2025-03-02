#!/bin/bash

# Variables - Change these as needed
PROJECT_ID="your-gcp-project-id"
ZONE="us-central1-a"
REGION="us-central1"
INSTANCE_TEMPLATE_NAME="gcp-instance-template"
INSTANCE_GROUP_NAME="gcp-instance-group"
MACHINE_TYPE="e2-medium"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
SCALING_POLICY_CPU_UTILIZATION=0.6

# Authenticate & Set Project
gcloud auth login
gcloud config set project $PROJECT_ID

# Step 1: Create an Instance Template
echo "Creating instance template..."
gcloud compute instance-templates create $INSTANCE_TEMPLATE_NAME \
    --machine-type=$MACHINE_TYPE \
    --image-family=$IMAGE_FAMILY \
    --image-project=$IMAGE_PROJECT \
    --boot-disk-size=10GB \
    --tags=http-server \
    --metadata=startup-script='#!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl start apache2' \
    --region=$REGION

# Step 2: Create a Managed Instance Group with Auto-Scaling
echo "Creating instance group..."
gcloud compute instance-groups managed create $INSTANCE_GROUP_NAME \
    --template=$INSTANCE_TEMPLATE_NAME \
    --size=1 \
    --zone=$ZONE \
    --base-instance-name=auto-instance

# Step 3: Configure Auto-Scaling Policy
echo "Configuring auto-scaling..."
gcloud compute instance-groups managed set-autoscaling $INSTANCE_GROUP_NAME \
    --max-num-replicas=4 \
    --min-num-replicas=1 \
    --target-cpu-utilization=$SCALING_POLICY_CPU_UTILIZATION \
    --cool-down-period=60 \
    --zone=$ZONE

# Step 4: Set Firewall Rules (Allow HTTP and Restrict SSH)
echo "Setting up firewall rules..."
gcloud compute firewall-rules create allow-http \
    --allow tcp:80 \
    --target-tags=http-server \
    --description="Allow HTTP traffic"

gcloud compute firewall-rules create restrict-ssh \
    --allow tcp:22 \
    --source-ranges=YOUR_IP/32 \
    --description="Restrict SSH to specific IP"

# Step 5: Verify Deployment
echo "Deployment completed. Verifying instances..."
gcloud compute instance-groups managed list

echo "Deployment successful! Visit your instance using the external IP."
