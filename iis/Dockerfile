FROM microsoft/iis:nanoserver

MAINTAINER Christoph Petersen <christoph.petersen@microsoft.com>

ENV NAME _

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY start.ps1 /
WORKDIR /

RUN New-Item -Path C:\site -Type Directory -Force | Out-Null; \
    Import-Module IISAdministration; \
    New-IISSite -Name "Site" -PhysicalPath C:\site -BindingInformation "*:8080:"

EXPOSE 8080

ENTRYPOINT .\start.ps1 -Name $env:NAME