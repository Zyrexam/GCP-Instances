#!/bin/bash

# Variables - Change these as needed
PROJECT_ID="your-gcp-project-id"
ZONE="us-central1-a"
REGION="us-central1"
INSTANCE_TEMPLATE_NAME="gcp-instance-template"
INSTANCE_GROUP_NAME="gcp-instance-group"

# Authenticate & Set Project
gcloud auth login
gcloud config set project $PROJECT_ID

# Step 1: Delete the Managed Instance Group
echo "Deleting instance group..."
gcloud compute instance-groups managed delete $INSTANCE_GROUP_NAME --zone=$ZONE --quiet

# Step 2: Delete the Instance Template
echo "Deleting instance template..."
gcloud compute instance-templates delete $INSTANCE_TEMPLATE_NAME --quiet

# Step 3: Delete Firewall Rules
echo "Deleting firewall rules..."
gcloud compute firewall-rules delete allow-http --quiet
gcloud compute firewall-rules delete restrict-ssh --quiet

# Step 4: Verify Cleanup
echo "Cleanup completed. Verifying remaining resources..."
gcloud compute instance-groups managed list
gcloud compute instance-templates list
gcloud compute firewall-rules list

echo "All resources deleted successfully! ✅"
