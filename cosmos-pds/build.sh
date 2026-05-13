#! /bin/bash

# env variables
PDS_HOSTNAME="pds.cosmos.aurictradecollective.org"
PDS_JWT_SECRET=$(openssl rand -hex 16)
PDS_ADMIN_PASSWORD=$(openssl rand -hex 32)
PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX=$(openssl ecparam --name secp256k1 --genkey --noout --outform DER | tail --bytes=+8 | head --bytes=32 | xxd --plain --cols 32)
PDS_DATA_DIRECTORY=/pds
PDS_BLOBSTORE_DISK_LOCATION=/pds/blocks
PDS_BLOB_UPLOAD_LIMIT=104857600
PDS_DID_PLC_URL=https://plc.directory
PDS_BSKY_APP_VIEW_URL=https://api.bsky.app
PDS_BSKY_APP_VIEW_DID=did:web:api.bsky.app
PDS_REPORT_SERVICE_URL=https://mod.bsky.app
PDS_REPORT_SERVICE_DID=did:plc:ar7c4by46qjdydhdevvrndac
PDS_CRAWLERS=https://bsky.network
LOG_ENABLED=true
PDS_RATE_LIMITS_ENABLED=true
PDS_INVITE_REQUIRED=true

rm -rf -p pds

git clone https://github.com/bluesky-social/pds.git
cd pds

rm compose.yaml
cp ../compose.yaml .

rm sample.env
echo "
PDS_HOSTNAME=$PDS_HOSTNAME
PDS_JWT_SECRET=\"$PDS_JWT_SECRET\"
PDS_ADMIN_PASSWORD=\"$PDS_ADMIN_PASSWORD\"
PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX=\"$PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX\"
PDS_DATA_DIRECTORY=\"$PDS_DATA_DIRECTORY\"
PDS_BLOBSTORE_DISK_LOCATION=\"$PDS_BLOBSTORE_DISK_LOCATION\"
PDS_BLOB_UPLOAD_LIMIT=$PDS_BLOB_UPLOAD_LIMIT
PDS_DID_PLC_URL=\"$PDS_DID_PLC_URL\"
PDS_BSKY_APP_VIEW_URL=\"$PDS_BSKY_APP_VIEW_URL\"
PDS_BSKY_APP_VIEW_DID=\"$PDS_BSKY_APP_VIEW_DID\"
PDS_REPORT_SERVICE_URL=\"$PDS_REPORT_SERVICE_URL\"
PDS_REPORT_SERVICE_DID=\"$PDS_REPORT_SERVICE_DID\"
PDS_CRAWLERS=\"$PDS_CRAWLERS\"
LOG_ENABLED=$LOG_ENABLED
PDS_RATE_LIMITS_ENABLED=$PDS_RATE_LIMITS_ENABLED
PDS_INVITE_REQUIRED=$PDS_INVITE_REQUIRED
" > sample.env

mkdir ./pds/

docker compose up --build -d

cd ../
# rm -rf pds

echo "Admin password is: $PDS_ADMIN_PASSWORD"
