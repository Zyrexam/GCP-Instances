# Deployment and Cleanup Scripts for GCP

## Files Included
1. **deploy_gcp.sh** - Script to deploy GCP VM with auto-scaling, IAM, and firewall rules.
2. **delete_gcp_resources.sh** - Script to delete all deployed resources when no longer needed.

## Running the Scripts on Windows Terminal (Git Bash or WSL)

### **Step 1: Ensure Git Bash or WSL is Installed**
If you are using Windows, install [Git Bash](https://git-scm.com/downloads) or enable [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install).

### **Step 2: Give Execute Permissions**
Run the following command in Git Bash or WSL to grant execution permissions to the scripts:
```sh
chmod +x deploy_gcp.sh delete_gcp_resources.sh
```

### **Step 3: Run the Deployment Script**
```sh
./deploy_gcp.sh
```
This will create the GCP VM, configure auto-scaling, firewall rules, and IAM roles.

### **Step 4: Run the Cleanup Script (When Needed)**
```sh
./delete_gcp_resources.sh
```
This will delete all resources created by the deployment script.

---
**Note:** Make sure you have the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated using `gcloud auth login` before running the scripts.

