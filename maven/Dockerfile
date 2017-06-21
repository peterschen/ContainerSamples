FROM jdk

MAINTAINER Christoph Petersen <christoph.petersen@microsoft.com>

ENV MVN_HOME "C:\mvn"
ENV MVNURI "http://apache.mirrors.pair.com/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /

RUN cd $env:TEMP; \
    Set-DnsClientServerAddress -InterfaceAlias (Get-NetAdapter).Name -ServerAddresses 168.63.129.16; \
    Invoke-WebRequest -Uri $env:MVNURI -OutFile $env:TEMP\mvn.zip; \
    Expand-Archive -Path $env:TEMP/mvn.zip -DestinationPath $env:TEMP; \
    Move-Item -Path $env:TEMP/apache-maven-* -Destination $env:MVN_HOME;
    
ENTRYPOINT "c:\mvn\bin\mvn.cmd"