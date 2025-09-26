# Docker Deployment Guide

This guide explains how to deploy the Coming Soon application using Docker and Docker Compose.

## Quick Start

### Option 1: Docker Run

Deploy with default settings:
```bash
docker run -d -p 8080:80 coming-soon
```

Deploy with custom configuration:
```bash
docker run -d -p 8080:80 \
  -e SITE_TITLE="Your Company" \
  -e BRAND_NAME="ACME" \
  -e SITE_MESSAGE="Something amazing is coming soon!" \
  coming-soon
```

### Option 2: Docker Compose

1. Clone the repository or copy the `docker-compose.yml` file
2. Optionally copy `.env.example` to `.env` and customize
3. Run:
```bash
docker compose up -d
```

## Environment Variables

All configuration is handled through environment variables:

### Required Variables
These have sensible defaults but you'll likely want to customize them:

| Variable | Default | Description |
|----------|---------|-------------|
| `SITE_TITLE` | "Coming Soon" | Page title shown in browser tab |
| `BRAND_NAME` | "NEXUS" | Your brand/company name displayed prominently |
| `SITE_MESSAGE` | Default developer message | Main message shown to visitors |

### Optional Variables
These have defaults that work out of the box:

| Variable | Default | Description |
|----------|---------|-------------|
| `SITE_DESCRIPTION` | "Coming Soon - We're building something amazing" | Meta description for SEO |
| `SITE_KEYWORDS` | "coming soon, template, website, launch" | Meta keywords for SEO |
| `BACKGROUND_VIDEO` | "./media/bgvideo1.mp4" | Path or URL to background video |
| `FAVICON` | "media/hourglass.png" | Path to favicon icon |

### Asset Override Variables
These enable advanced customization:

| Variable | Default | Description |
|----------|---------|-------------|
| `CUSTOM_CSS_URL` | "" | URL to custom CSS file to override styles |
| `CUSTOM_LOGO_URL` | "" | URL to custom logo image to replace brand text |

## Asset Customization

### Method 1: Environment Variables with URLs

Use external URLs to override assets:
```bash
docker run -d -p 8080:80 \
  -e CUSTOM_CSS_URL="https://cdn.example.com/custom.css" \
  -e CUSTOM_LOGO_URL="https://cdn.example.com/logo.png" \
  -e BACKGROUND_VIDEO="https://cdn.example.com/video.mp4" \
  coming-soon
```

### Method 2: Volume Mounting

Mount local files to override default assets:

#### Custom Media Directory
```bash
docker run -d -p 8080:80 \
  -v ./custom-media:/usr/share/nginx/html/media:ro \
  coming-soon
```

#### Custom CSS File
```bash
docker run -d -p 8080:80 \
  -v ./custom-styles.css:/usr/share/nginx/html/custom/custom.css:ro \
  -e CUSTOM_CSS_URL="/custom/custom.css" \
  coming-soon
```

#### Custom Assets Directory
```bash
docker run -d -p 8080:80 \
  -v ./custom-assets:/usr/share/nginx/html/custom:ro \
  coming-soon
```

### Method 3: Docker Compose with Volumes

Uncomment volume mounts in `docker-compose.yml`:
```yaml
volumes:
  - ./custom-assets:/usr/share/nginx/html/custom:ro
  - ./custom-media:/usr/share/nginx/html/media:ro
  - ./custom-styles.css:/usr/share/nginx/html/custom/custom.css:ro
```

## Production Deployment Examples

### Example 1: Simple Corporate Landing

```bash
docker run -d -p 80:80 --name company-coming-soon \
  -e SITE_TITLE="ACME Corporation - Coming Soon" \
  -e BRAND_NAME="ACME CORP" \
  -e SITE_MESSAGE="We're revolutionizing the industry. Something incredible is coming your way!" \
  -e SITE_DESCRIPTION="ACME Corporation is launching something revolutionary" \
  -e SITE_KEYWORDS="ACME, innovation, technology, corporate, launch" \
  --restart unless-stopped \
  coming-soon
```

### Example 2: Startup with Custom Assets

```bash
docker run -d -p 80:80 --name startup-landing \
  -e SITE_TITLE="TechStart - Launching Soon" \
  -e BRAND_NAME="TechStart" \
  -e SITE_MESSAGE="We're building the future of technology. Join us on this incredible journey!" \
  -e CUSTOM_LOGO_URL="https://cdn.techstart.com/logo.png" \
  -e CUSTOM_CSS_URL="https://cdn.techstart.com/brand.css" \
  -e BACKGROUND_VIDEO="https://cdn.techstart.com/hero-video.mp4" \
  --restart unless-stopped \
  coming-soon
```

### Example 3: Docker Compose Production

Create a `.env` file:
```env
SITE_TITLE=My Amazing Product
BRAND_NAME=AMAZING
SITE_MESSAGE=Get ready for something that will change everything. We're putting the finishing touches on our revolutionary platform.
SITE_DESCRIPTION=Amazing Product - Revolutionary platform coming soon
SITE_KEYWORDS=amazing, product, revolutionary, platform, technology
CUSTOM_LOGO_URL=https://cdn.mycompany.com/logo.png
```

Then deploy:
```bash
docker compose up -d
```

## Health Checks and Monitoring

The container includes a health check endpoint at `/health`:

```bash
# Check if the application is healthy
curl http://localhost:8080/health
```

Docker Compose includes automatic health checks. View the status:
```bash
docker compose ps
```

## Advanced Configuration

### Using External Reverse Proxy

For production, place behind a reverse proxy like nginx or Traefik:

```yaml
# docker-compose.yml with Traefik labels
services:
  coming-soon:
    build: .
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.coming-soon.rule=Host(`example.com`)"
      - "traefik.http.routers.coming-soon.tls.certresolver=letsencrypt"
    environment:
      - SITE_TITLE=Example.com - Coming Soon
      - BRAND_NAME=EXAMPLE
```

### SSL/TLS Termination

When using a reverse proxy, the container serves plain HTTP. Configure SSL at the reverse proxy level.

### Performance Tuning

The nginx configuration includes:
- Gzip compression for static assets
- Browser caching headers
- Optimized for serving static content

For high-traffic deployments, consider:
- Using a CDN for media assets
- Implementing rate limiting at the reverse proxy
- Horizontal scaling with multiple container instances

## Troubleshooting

### Common Issues

1. **Port already in use**
   ```bash
   # Use a different port
   docker run -d -p 8081:80 coming-soon
   ```

2. **Environment variables not applied**
   ```bash
   # Check container logs
   docker logs <container-name>
   ```

3. **Custom assets not loading**
   ```bash
   # Verify file permissions and URLs
   docker exec -it <container-name> ls -la /usr/share/nginx/html/custom/
   ```

4. **Application not starting**
   ```bash
   # Check container status and logs
   docker ps -a
   docker logs <container-name>
   ```

### Development Mode

For development with live reload, use the dev profile:
```bash
docker compose --profile dev up
```

This starts a simple Python HTTP server with your local files mounted.

## Building from Source

To build your own image:

```bash
# Clone the repository
git clone <repository-url>
cd coming-soon

# Build the image
docker build -t my-coming-soon .

# Run with custom image
docker run -d -p 8080:80 my-coming-soon
```

## Security Considerations

- The application serves static content only
- No user input is processed
- Nginx is configured with security headers
- Assets are served with appropriate cache headers
- No sensitive information is logged

For production deployment:
- Always use HTTPS via reverse proxy
- Keep the base nginx:alpine image updated
- Monitor for security updates
- Consider using Docker secrets for sensitive configuration