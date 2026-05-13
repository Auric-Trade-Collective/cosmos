#! /bin/bash

rm -rf -p pds

git clone https://github.com/bluesky-social/pds.git
cd pds

rm compose.yaml
cp ../compose.yaml .

mkdir ./pds/

docker compose up --build -d

cd ../
# rm -rf pds
