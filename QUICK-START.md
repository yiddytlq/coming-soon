# Quick Start Guide

Get your coming soon page deployed in under 2 minutes!

## 🚀 Docker Deployment (Recommended)

### Option 1: Default Deployment
```bash
docker run -d -p 8080:80 coming-soon
```
Visit: http://localhost:8080

### Option 2: Custom Branding
```bash
docker run -d -p 8080:80 \
  -e SITE_TITLE="Your Company Name" \
  -e BRAND_NAME="YOUR BRAND" \
  -e SITE_MESSAGE="We're building something amazing!" \
  coming-soon
```

### Option 3: Docker Compose
```bash
# 1. Copy environment template
cp .env.example .env

# 2. Edit .env with your values
# 3. Deploy
docker compose up -d
```

## 🎨 Customization

### Environment Variables
| Variable | Example |
|----------|---------|
| `SITE_TITLE` | "ACME Corporation - Coming Soon" |
| `BRAND_NAME` | "ACME" |
| `SITE_MESSAGE` | "Something revolutionary is coming!" |
| `CUSTOM_LOGO_URL` | "https://cdn.example.com/logo.png" |
| `CUSTOM_CSS_URL` | "https://cdn.example.com/styles.css" |

### Custom Assets
```bash
# Mount local assets
docker run -d -p 8080:80 \
  -v ./custom-assets:/usr/share/nginx/html/custom:ro \
  coming-soon
```

## 📖 Full Documentation
- **[DOCKER.md](DOCKER.md)** - Complete Docker deployment guide
- **[README.md](README.md)** - Full project documentation
- **[examples/](examples/)** - Deployment examples

## 🔧 Quick Commands
```bash
# Check container status
docker ps

# View logs
docker logs <container-name>

# Health check
curl http://localhost:8080/health

# Stop and cleanup
docker stop <container-name> && docker rm <container-name>
```

## 🆘 Need Help?
- Check the [troubleshooting section](DOCKER.md#troubleshooting) in DOCKER.md
- Review [deployment examples](examples/docker-examples.sh)
- Ensure port 8080 is available or use a different port: `-p 8081:80`