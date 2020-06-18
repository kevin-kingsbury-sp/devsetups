# SQL Server in Docker

This is an update to the microsoft released SQL Server 2017 docker image.  This image will allow specifying some sql files to be executed on server startup.

To use this image, first you need to build the updated image. Run the following to do this.
- Run "docker-compose build db"

Once the build is completed, "docker images" will show a custom mssql server image called "custom/mssql/server:2017-latest"

After the image is built, perform the following to start the image.
- Add your create tables script to the sqlscripts directory.  The script needs to start with a number greater than 10_ and end with .sql.  For example: **20_create_tables.sql**
- Run "docker-compose up".  This will start the container and print the logging information to the stdout.
- Hit ctrl-c to stop the container.
- Run "docker-compose rm -f" to remove the container completely.
