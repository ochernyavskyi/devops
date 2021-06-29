#!/bin/bash

echo "This script will help U to deploy the docker image"
sleep 2
sudo docker build -t flask_image .
echo "Image has been created!"
sleep 2
echo "Container should be run at few moments"
sudo docker run -d --rm -p 8080:8080 --name flask_container flask_image
sleep 3
curl -k -XPOST -d'{"animal":"cow", "sound":"whoooaaa", "count": 5}' http://localhost:8080
