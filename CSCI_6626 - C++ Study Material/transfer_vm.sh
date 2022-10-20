#! /bin/bash

# Local variables
USER="mdttest"
IP_HOST="192.168.159.130:/home/$USER/Desktop"
FILE_PATH="w9_bar_graph"

echo "Transferring files.d.."
scp -r $FILE_PATH $USER@$IP_HOST