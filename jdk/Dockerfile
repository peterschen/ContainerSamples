FROM microsoft/nanoserver:10.0.14393.1358

MAINTAINER Christoph Petersen <christoph.petersen@microsoft.com>

# ENV NAME _

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /

# Install 7zip
RUN New-Item -Path "c:\tools" -Type Directory;
COPY 7z.exe /tools
COPY 7z.dll /tools

RUN cd $env:TEMP \
    Invoke-WebRequest -OutFile $env:TEMP\jdk.exe -Uri http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220305_d54c1d3a095b4ff2b6607d096fa80163 \
    \tools\7z.exe e jdk.exe .rsrc\1033\JAVA_CAB10\111 \
    \tools\7z.exe e 111 \
    \tools\7z.exe x -ojdk_dir tools.zip \
    Get-ChildItem -Path jdk_dir -Recurse -Filter "*.pack" | % { jdk_dir\bin\unpack200 -r $_.FullName "$($_.DirectoryName)\$($_.BaseName).jar" } \
    Move-Item -Path $env:TEMP\jdk_dir "c:\jdk" \
    Remove-Item -Force 111 tools.zip;
    
ENTRYPOINT c:\jdk\bin\java.exe