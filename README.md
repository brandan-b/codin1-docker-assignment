# Docker File Assignment - Create React App on port 7775

This repo contains a ready-to-run Dockerized **development environment** that displays an `<h1>` with the exact text:

> “Codin 1” website

It uses **Create React App** and runs the dev server on **localhost:7775**.

---

## What you'll submit
- `Dockerfile`
- `README.md` (this file)

These satisfy the assignment requirements:
- The site shows an `<h1>` with the text **“Codin 1” website**
- Dev environment is created using **Create React App**
- The container is run with the name **`lastName_firstName_coding_assignment11`**
- The site files live in a Docker **workdir** named **`lastName_firstName_site`**

> **Note:** You control the `lastName`/`firstName` via build args so your workdir matches the required pattern. The container name is set when you run `docker run`.

---

## Prerequisites
- Windows 10/11
- **Docker Desktop** installed and running

---

## Quick start (PowerShell)

1) **Open PowerShell** in this folder (the one with the `Dockerfile`).  
   Tip: Shift+Right-click the folder → “Open PowerShell window here”.

2) **Build the image**, setting your name for the required workdir:
   ```powershell
   # Replace with your actual names
   $LastName  = "Brajkovich"
   $FirstName = "Brandan"

   docker build `
     --build-arg LASTNAME=$LastName `
     --build-arg FIRSTNAME=$FirstName `
     -t codin1:latest .
   ```

   This produces a workdir of `/usr/src/$LastName_$FirstName_site` inside the image.

3) **Run the container with the required name** and port mapping:
   ```powershell
   $ContainerName = "${LastName}_${FirstName}_coding_assignment11"
   docker run --name $ContainerName -p 7775:7775 codin1:latest
   ```

   - `--name` enforces the required container name format.
   - `-p 7775:7775` maps the app to **http://127.0.0.1:7775**.

4) **Open your browser** to:  
   http://127.0.0.1:7775/

   You should see a full-page heading: **“Codin 1” website**.

5) **Stop** the container with `Ctrl+C` in the PowerShell window. To remove it later:
   ```powershell
   docker rm -f $ContainerName
   ```

---

## What’s in the image?
- Base image: `node:20-alpine`
- `WORKDIR`: `/usr/src/<lastName>_<firstName>_site` (required pattern)
- `react`, `react-dom`, `react-scripts` (Create React App tooling)
- Dev server binds to `0.0.0.0` on port **7775** for Docker access

Env vars set in the `Dockerfile`:
- `PORT=7775` → CRA dev server port
- `HOST=0.0.0.0` → Listen on all interfaces (required in containers)
- `CHOKIDAR_USEPOLLING=true` → Reliable file watching on Windows/macOS

---

## Common commands

**See running containers**
```powershell
docker ps
```

**Stop the container**
```powershell
docker stop $ContainerName
```

**Remove the container**
```powershell
docker rm -f $ContainerName
```

**Rebuild after changes**
```powershell
docker build --build-arg LASTNAME=$LastName --build-arg FIRSTNAME=$FirstName -t codin1:latest .
```

---

## Optional: one-click script (PowerShell)
You can use `run.ps1` to build and run with your name in one go:
```powershell
# Example with your own name
./run.ps1 -LastName "Brajkovich" -FirstName "Brandan"
```

The script:
- Builds the image with the correct workdir name
- Removes any previous container with the same name
- Runs the container as **`lastName_firstName_coding_assignment11`**
- Serves the app at http://127.0.0.1:7775/

---

## Verification checklist (what your grader will see)
- ✅ `docker ps` shows a container named **`<lastName>_<firstName>_coding_assignment11`**
- ✅ Inside the container, the workdir is **`/usr/src/<lastName>_<firstName>_site`**
- ✅ Visiting **http://127.0.0.1:7775** shows an `<h1>` with exact text **“Codin 1” website**
- ✅ Delivered `Dockerfile` and `README.md`

---

## Troubleshooting

**Port 7775 already in use**
- Close whatever is using it, or run on a different host port (e.g., `-p 7776:7775`).
  You must still expose **container** port 7775 to meet the requirement.

**Black/blank page**
- Give it a few seconds on first start; dependencies are already installed during build,
  but the dev server still needs to compile once at runtime.

**Container name already exists**
```powershell
docker rm -f $ContainerName
```

**Reset everything**
```powershell
docker rm -f $ContainerName 2>$null
docker rmi codin1:latest 2>$null
docker build --build-arg LASTNAME=$LastName --build-arg FIRSTNAME=$FirstName -t codin1:latest .
```
