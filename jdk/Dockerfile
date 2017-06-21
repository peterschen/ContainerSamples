FROM microsoft/nanoserver:10.0.14393.1358

MAINTAINER Christoph Petersen <christoph.petersen@microsoft.com>

ENV JAVA_HOME "c:\jdk"
ENV JDKURI "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-windows-x64.exe"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /

# Install 7zip
RUN New-Item -Path "c:\tools" -Type Directory | Out-Null;
COPY 7z.exe /tools
COPY 7z.dll /tools

# Copy JDK (workaround until iwr works properly - https://github.com/PowerShell/PowerShell/issues/2896)
COPY jdk-*-windows-x64.exe /Users/ContainerAdministrator/AppData/Local/Temp/jdk.exe

RUN cd $env:TEMP; \
    # Set-DnsClientServerAddress -InterfaceAlias (Get-NetAdapter).Name -ServerAddresses 168.63.129.16; \
    # $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession; \
    # $cookie = New-Object System.Net.Cookie -ArgumentList @("oraclelicense", "accept-securebackup-cookie", "/", ".oracle.com"); \
    # $session.Cookies.Add("http://download.oracle.com", $cookie); \
    # Invoke-WebRequest -Uri $env:JDKURI -WebSession $session -OutFile $env:TEMP\jdk.exe; \
    \tools\7z.exe e jdk.exe .rsrc\1033\JAVA_CAB10\111 | Out-Null; \
    \tools\7z.exe e 111 | Out-Null; \
    \tools\7z.exe x -ojdk_dir tools.zip | Out-Null; \
    Get-ChildItem -Path jdk_dir -Recurse -Filter '*.pack' | % { \
        $target = $_.DirectoryName; \
        $target += '/'; \
        $target += $_.Basename; \
        $target += '.jar'; \
        jdk_dir\bin\unpack200.exe -r $_.FullName $target; \
    }; \
    Move-Item -Path $env:TEMP\jdk_dir "c:\jdk"; \
    Remove-Item -Force jdk.exe; \
    Remove-Item -Force 111; \
    Remove-Item -Force tools.zip;
    
ENTRYPOINT c:\jdk\bin\java.exe