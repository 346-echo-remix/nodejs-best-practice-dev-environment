#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=========================================="
echo "Starting GCP gcloud CLI and Terraform Installation"
echo "=========================================="

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then

	echo -ne "Executing script with pre-sudo binary calls...\n"

# Update system and install prerequisite packages
echo "--> Updating system packages and installing prerequisites..."
sudo apt-get update -y
# Removed 'software-properties-common' from install list.
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl #software-properties-common

# ---------------------------------------------------------------------
# 1. Install Google Cloud SDK (gcloud CLI)
# ---------------------------------------------------------------------
echo "--> Adding Google Cloud CLI repository..."

# Import Google Cloud public key safely
#curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Add the gcloud apt repository for Debian 12
sudo touch /etc/apt/sources.list.d/google-cloud-sdk.list
sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

echo "--> Installing gcloud CLI..."
sudo apt-get update -y && sudo apt-get install -y google-cloud-cli

# ---------------------------------------------------------------------
# 2. Install HashiCorp Terraform
# ---------------------------------------------------------------------
echo "--> Adding HashiCorp Terraform repository..."

# Import HashiCorp public key safely
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the HashiCorp apt repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "--> Installing Terraform..."
sudo apt-get update -y && sudo apt-get install -y terraform

# ---------------------------------------------------------------------
# 3. Verification Checks
# ---------------------------------------------------------------------
echo "=========================================="
echo "Running Verification Checks..."
echo "=========================================="

# Check gcloud
if command -v gcloud &> /dev/null; then
    echo "✓ Google Cloud CLI installed successfully!"
    gcloud --version | head -n 1
else
    echo "✗ Google Cloud CLI installation FAILED."
fi

echo "------------------------------------------"

# Check Terraform
if command -v terraform &> /dev/null; then
    echo "✓ Terraform installed successfully!"
    terraform --version
else
    echo "✗ Terraform installation FAILED."
fi

echo "=========================================="
echo "Done!"
echo "=========================================="
else

  echo -ne "You are executing this bash script as root."

  # Update system and install prerequisite packages
echo "--> Updating system packages and installing prerequisites..."
apt-get update -y
apt-get install -y apt-transport-https ca-certificates gnupg curl software-properties-common

# ---------------------------------------------------------------------
# 1. Install Google Cloud SDK (gcloud CLI)
# ---------------------------------------------------------------------
echo "--> Adding Google Cloud CLI repository..."

# Import Google Cloud public key safely
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Add the gcloud apt repository for Debian 12
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.p/google-cloud-sdk.list

echo "--> Installing gcloud CLI..."
apt-get update -y && apt-get install -y google-cloud-cli

# ---------------------------------------------------------------------
# 2. Install HashiCorp Terraform
# ---------------------------------------------------------------------
echo "--> Adding HashiCorp Terraform repository..."

# Import HashiCorp public key safely
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the HashiCorp apt repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com/debian $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

echo "--> Installing Terraform..."
apt-get update -y && apt-get install -y terraform

# ---------------------------------------------------------------------
# 3. Verification Checks
# ---------------------------------------------------------------------
echo "=========================================="
echo "Running Verification Checks..."
echo "=========================================="

# Check gcloud
if command -v gcloud &> /dev/null; then
    echo "✓ Google Cloud CLI installed successfully!"
    gcloud --version | head -n 1
else
    echo "✗ Google Cloud CLI installation FAILED."
fi

echo "------------------------------------------"

# Check Terraform
if command -v terraform &> /dev/null; then
    echo "✓ Terraform installed successfully!"
    terraform --version
else
    echo "✗ Terraform installation FAILED."
fi

echo "=========================================="
echo "Done!"
echo "=========================================="

fi
