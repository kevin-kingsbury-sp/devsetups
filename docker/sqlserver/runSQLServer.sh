#!/bin/bash

########### SIGINT handler ############
function _int() {
   echo "Stopping container."
   echo "SIGINT received, shutting down database!"
   kill $serverPID
}

########### SIGTERM handler ############
function _term() {
   echo "Stopping container."
   echo "SIGTERM received, shutting down database!"
   kill $serverPID
}

########### SIGKILL handler ############
function _kill() {
   echo "SIGKILL received, shutting down database!"
   kill -9 $serverPID
}

# Set SIGINT handler
trap _int SIGINT

# Set SIGTERM handler
trap _term SIGTERM

# Set SIGKILL handler
trap _kill SIGKILL

#start SQL Server and run the script to configure this instance
/opt/mssql/bin/sqlservr &
serverPID=$!

# Pause for 30s to give the server time to start.
echo "Waiting 30 seconds for the SQLServer to start"
sleep 30

# Run any user defined scripts and sql files
/runUserScripts.sh /docker-entrypoint-initdb.d

echo "SQL Server database is ready for use!"

wait $serverPID
