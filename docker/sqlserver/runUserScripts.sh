#!/bin/bash
SCRIPTS_DIR=$1
SQLCMD=/opt/mssql-tools/bin/sqlcmd

# Check whether parameter has been passed on
if [ -z "$SCRIPTS_DIR" ]; then
  echo "$0: No SCRIPTS_DIR directory argument specified. No scripts will be run";
  exit 1;
fi;

# Execute custom provided files (only if directory exists and has files in it)
if [ -d "$SCRIPTS_DIR" ] && [ -n "$(ls -A $SCRIPTS_DIR)" ]; then

  echo "";
  echo "Executing user defined scripts"

  for f in $SCRIPTS_DIR/*; do
      case "$f" in
          *.sh)     echo "$0: running $f"; . "$f" ;;
          *.sql)    echo "$0: running $f"; $SQLCMD -S localhost -U sa -P $SA_PASSWORD -d master -i $f ;;
          *)        echo "$0: ignoring $f" ;;
      esac
      echo "";
  done

  echo "DONE: Executing user defined scripts"
  echo "";

fi
