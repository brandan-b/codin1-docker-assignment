param(
  [string]$LastName="Brajkovich",
  [string]$FirstName="Brandan"
)

$Image="codin1:latest"
$ContainerName="${LastName}_${FirstName}_coding_assignment11"

Write-Host "Building Docker image '$Image' with WORKDIR /usr/src/${LastName}_${FirstName}_site ..." -ForegroundColor Cyan
docker build --build-arg LASTNAME=$LastName --build-arg FIRSTNAME=$FirstName -t $Image .

$existing = (docker ps -aq -f "name=^$ContainerName$")
if ($existing) {
  Write-Host "Removing existing container $ContainerName ..." -ForegroundColor Yellow
  docker rm -f $ContainerName | Out-Null
}

Write-Host "Running container $ContainerName on http://127.0.0.1:7775 ..." -ForegroundColor Green
docker run --name $ContainerName -p 7775:7775 $Image
