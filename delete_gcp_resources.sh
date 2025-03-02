# Variables
PROJECT_ID="my-gcp-project-123456"
ZONE="us-central1-a"
INSTANCE_GROUP="web-server-group"
INSTANCE_TEMPLATE="web-server-template"

# Set project
gcloud config set project $PROJECT_ID

# Delete the managed instance group
gcloud compute instance-groups managed delete $INSTANCE_GROUP --zone=$ZONE --quiet

# Delete the instance template
gcloud compute instance-templates delete $INSTANCE_TEMPLATE --quiet

# Delete the firewall rules
gcloud compute firewall-rules delete allow-http --quiet
gcloud compute firewall-rules delete allow-ssh-john --quiet

# Remove IAM role binding for the user
gcloud projects remove-iam-policy-binding $PROJECT_ID \
    --member="user:john.doe@example.com" \
    --role="roles/compute.admin" \
    --quiet

echo "All resources deleted successfully!"
