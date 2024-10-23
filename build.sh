#!/bin/sh
VERSION=$(<VERSION)
TARGET=$(<TARGET)
docker build . -t $TARGET:latest -t $TARGET:$VERSION --build-arg VERSION=$VERSION --no-cache --platform linux/amd64 --secret id=ROOTPASS,src=./ROOTPASS