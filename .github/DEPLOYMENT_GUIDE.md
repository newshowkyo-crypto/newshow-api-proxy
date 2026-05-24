# GitHub Actions Automatic Deployment Setup Guide

## Prerequisites

1. **VPS Information**
   - VPS IP address or domain
   - SSH username (usually `root` or `ubuntu`)
   - SSH private key

2. **VPS Environment**
   - Docker and Docker Compose installed
   - Git installed

## Step 1: Prepare SSH Key

If you don't have an SSH key yet, run on your local machine:

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
```

## Step 2: Add SSH Public Key on VPS

```bash
# On VPS
echo "your-public-key-content" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

## Step 3: Configure GitHub Secrets

1. Go to repository → Settings → Secrets and variables → Actions
2. Create the following Secrets:

### Secret 1: VPS_HOST
- **Name**: `VPS_HOST`
- **Value**: Your VPS IP address or domain (e.g., `192.168.1.1` or `api.example.com`)

### Secret 2: VPS_USER
- **Name**: `VPS_USER`
- **Value**: SSH username (usually `root`)

### Secret 3: VPS_SSH_KEY
- **Name**: `VPS_SSH_KEY`
- **Value**: Full SSH private key content (copy from `~/.ssh/id_rsa`)

**⚠️ Important**: Never expose these sensitive credentials in code!

## Step 4: Test Automatic Deployment

1. Make a small change and push to main branch
2. Go to GitHub → Actions to check if deployment is triggered
3. If successful, you'll see "Auto Deploy to VPS" workflow completed

## Troubleshooting

### SSH connection failed
- Check if VPS_HOST is correct
- Check if VPS firewall allows port 22
- Check if SSH public key is added to VPS

### Docker command not found
- Run on VPS: `sudo apt install docker.io docker-compose`
- Run: `sudo usermod -aG docker $USER`

### Permission denied
- Ensure SSH user has write permission to `/opt/newshow-api-proxy`
- Run: `sudo chown -R $USER:$USER /opt/newshow-api-proxy`

## Verify Deployment

After deployment, visit:
```
http://your-vps-ip:3000
```

You should see the New API admin interface!
