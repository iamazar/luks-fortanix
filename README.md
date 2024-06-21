# Fortanix LUKS Script
## Fortanix | GulfIT ##
contact: azarbemd@gmail.com

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Configuration](#configuration)
4. [Running the Script](#running-the-script)
5. [Example Usage](#example-usage)

---

## Introduction
This script is an enhanced and tested version of existing script available in Fortanix support portal -> https://support.fortanix.com/hc/en-us/articles/360016187791-Using-Fortanix-Data-Security-Manager-for-block-storage-encryption-on-Linux-servers 
This script helps in creating and managing LUKS-encrypted partitions using Fortanix for key management. The script automates the process of retrieving the encryption key from Fortanix and setting up LUKS encryption on the specified partition.

---

## Prerequisites
Before running the script, ensure you have the following:
- A Fortanix account with API access.
- The `curl` command-line tool installed.
- The `cryptsetup` utility installed.
- A secret created in Fortanix with the base64-encoded key. Refer here for more details -> https://support.fortanix.com/hc/en-us/articles/360016187791-Using-Fortanix-Data-Security-Manager-for-block-storage-encryption-on-Linux-servers

---

## Configuration
Update the following variables in the script with your details:

API_ENDPOINT= # Your Fortanix API endpoint
PARTITION=   # The partition you want to encrypt, e.g., /dev/sdb3
api_key=     # Your Fortanix API key
key_uuid=    # UUID of the encryption key in Fortanix
encrypted_disk_name=encrypted-disk # You can give any meaningful name


##Running the Script
Once everything is configured, run the script as follows:
Ensure the script has execution permissions: chmod +x your-script.sh


##Run the script
./your-script.sh


##The script will:
    Authenticate with Fortanix using the provided API key.
    Retrieve the encryption key from Fortanix.
    Set up LUKS encryption on the specified partition.
    Open the encrypted partition.

##After running the script, you can format and mount the encrypted partition manually:
# Format the encrypted partition with ext4 filesystem
mkfs.ext4 /dev/mapper/<encrypted_disk_name>

# Create a mount point directory, you can give any name as directory
mkdir /mnt/encrypted

# Mount the encrypted partition
mount /dev/mapper/encrypted_disk_name> /mnt/encrypted
