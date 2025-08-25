# Docker File Assignment – Create React App on port 7775

This project sets up a Dockerized **development environment** that displays an `<h1>` with the text:

> “Codin 1” website

It uses **Create React App** and runs the dev server on **localhost:7775**.

---

## Requirements covered
- Displays `<h1>` with the text **“Codin 1” website**  
- Environment is built using **Create React App**  
- Container name follows the format **`lastName_firstName_coding_assignment11`**  
- Files are hosted inside a Docker **workdir** called **`lastName_firstName_site`**

---

## Prerequisites
- Windows 10/11  
- Docker Desktop installed and running  

---

## Quick start (PowerShell)

1. Open PowerShell in this folder (where the `Dockerfile` is).  
   > Shift + Right-click the folder → “Open PowerShell window here”

2. Build the image with your name:
   ```powershell
   $LastName  = "Brajkovich"
   $FirstName = "Brandan"

   docker build `
     --build-arg LASTNAME=$LastName `
     --build-arg FIRSTNAME=$FirstName `
     -t codin1:latest .
 3. Run the container
   $ContainerName = "${LastName}_${FirstName}_coding_assignment11"
   docker run --name $ContainerName -p 7775:7775 codin1:latest
 
 4. Open in browser
   Visit: http://127.0.0.1:7775
   You should see the <h1> text: “Codin 1” website

 5. Stop or remove the container
   Stop with Ctrl+C
    Or run this in powershell:
   docker stop $ContainerName
   docker rm -f $ContainerName
