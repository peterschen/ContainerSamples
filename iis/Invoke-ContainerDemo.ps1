param
(
    [string] $NamePrefix = "iis",
    [int] $Containers = 5,
    [int] $PortBase = 50000
)

$Containers++;

$oldids = docker ps -a --filter "ancestor=containerdemo" --format "{{.ID}}";
foreach($oldid in $oldids)
{
    Write-Host -NoNewline "Removing old container: ";
    docker rm -f $oldid;
}

for ($i = 1; $i -lt $Containers; $i++)
{
    $port = "$($PortBase + $i):8080";
    $name = "$($NamePrefix)$($i)";

    Write-Host -NoNewline "Creating container $name on $($port): ";
    docker run --name $name -d -p $port -e NAME=$name containerdemo;
}