#!/bin/bash

org=$1
collection=$2
action=$3

ROOT=/mnt/integrity_store/starling/internal
DROPBOX_ROOT=/mnt/store/dropbox/Dropbox/integrity-stg-starlinglab-org

systemctl stop integrity-backend
mv $ROOT/$org/$collection/$action $ROOT/$org/$collection/$action.old
mkdir -p $DROPBOX_ROOT/$org/$collection/$action
chown -R starling.starling $DROPBOX_ROOT
chmod a+rwX $DROPBOX_ROOT/$org/$collection/$action
ln -s $DROPBOX_ROOT/$org/$collection/$action $ROOT/$org/$collection/$action
systemctl start integrity-backend
