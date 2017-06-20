param
(
        [string] $Name
);

if(-not (Test-Path "c:\site\index.html"))
{
        Add-Content -Path "c:\site\index.html" -Value "<html><head><title>IIS on $Name</title></head><body>This is proudly served from <strong>$Name</strong></body></html>";
}

Start-Process -FilePath "C:\ServiceMonitor.exe" -ArgumentList "w3svc" -Wait;