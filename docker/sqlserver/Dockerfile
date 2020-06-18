FROM mcr.microsoft.com/mssql/server:2017-latest

# Bundle app source
COPY ./runSQLServer.sh ./runUserScripts.sh /

RUN chmod u+x /runSQLServer.sh /runUserScripts.sh

CMD exec /runSQLServer.sh
