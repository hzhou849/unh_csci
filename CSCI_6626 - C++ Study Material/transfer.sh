#! /bin/bash

# Local variables
USER="mdttest"
IP_HOST="192.168.159.130:/home/$USER/Desktop"
PATH="w9_bar_graph"

echo "Transferring files..."
scp -v -r $PATH $USER@$IP_HOST