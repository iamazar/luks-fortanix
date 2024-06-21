##      FORTANIX LUKS SCRIPT       ##
##      FORTANIX | GULFIT          ##
##===================================

# UPDATE YOUR DETAILS HERE

API_ENDPOINT=
PARTITION= #WHICH PARTITION YOU WANT TO ENCRYPT, eg. /dev/sdb3
api_key=
key_uuid=
encrypted_disk_name=encrypted-disk #YOU CAN GIVE ANY MEANINGFUL NAME

# DONT TOUCH ANYTHING HERE

app_login() {
response=$(curl -k -v -s -X POST -H "Content-Type: application/json" -H "Authorization: Basic $api_key" -d '' "$API_ENDPOINT/sys/v1/session/auth" 2>&1)
access_token=$(echo "$response" | grep -o '"access_token":"[^"]*' | awk -F'"' '{print $4}')
echo "Access Token = $access_token"
echo "Sending GET request to $API_ENDPOINT/crypto/v1/keys/${key_uuid}/export"
response=$(curl -k -v -s -X GET -H "Authorization: Bearer $access_token" "$API_ENDPOINT/crypto/v1/keys/${key_uuid}/export" 2>&1)
encoded_value=$(echo "$response" | grep -o '"value":"[^"]*' | awk -F'"' '{print $4}')
LuksClearTextKey=$(echo "$encoded_value" | base64 --decode)

# IF YOU WANT LUKS1 REMOVE "--type luks2" BELOW

echo "$LuksClearTextKey" | cryptsetup -v luksFormat --type luks2 --hash=sha256 $PARTITION  # Optional: Add --header=<header_name>
echo "$LuksClearTextKey" | cryptsetup -v luksOpen $PARTITION $encrypted_disk_name
unset LuksClearTextKey

cryptsetup status $encrypted_disk_name

echo ""
echo ""
echo "############################################################"
echo "##                       LUKS is ACTIVE                   ##"
echo "##                 Format & Mount it Manually             ##"
echo "     Example: mkfs.ext4 /dev/mapper/$encrypted_disk_name    "
echo "   mount /dev/mapper/encrypted-disk /mnt/<directory>        "
echo "############################################################"
echo ""
echo ""
}

app_login
