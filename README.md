# Coming Soon Page Template

A professional, responsive coming soon page template that can be deployed in minutes with Docker. Perfect for launches, maintenance pages, or temporary landing pages.

## Features

✨ **Responsive design** that works beautifully on all devices  
🎥 **Video background support** with fallback options  
🎨 **Clean, modern aesthetic** that's ready to use  
🐳 **Docker-ready** with single-command deployment  
⚙️ **Easy customization** via environment variables  
🔧 **Asset override** support for logos, styles, and media  

## Quick Start

### Docker Deployment (Recommended)

**Option 1: Docker Compose (No customization)**
```yaml
# docker-compose.yml
services:
  coming-soon:
    build: https://github.com/yiddytlq/coming-soon.git
    ports:
      - "8080:80"
    environment:
      - SITE_TITLE=Coming Soon
      - BRAND_NAME=NEXUS
      - SITE_MESSAGE=Hello fellow developers! We're currently building our new application.
      # Customize these values:
      # - SITE_TITLE=Your Company - Coming Soon
      # - BRAND_NAME=YOUR COMPANY
      # - SITE_MESSAGE=We're building something amazing!
      # - SITE_DESCRIPTION=Your custom description
      # - SITE_URL=https://yoursiteurl.com
      # - OG_IMAGE=https://yourcompany.com/social-image.jpg
      # - CUSTOM_LOGO_URL=https://cdn.yoursiteurl.com/logo.png
      # - CUSTOM_CSS_URL=https://cdn.yoursiteurl.com/styles.css
      # - BACKGROUND_VIDEO=https://cdn.yoursiteurl.com/video.mp4
    restart: unless-stopped
```
```bash
docker compose up -d
```
Visit: http://localhost:8080

**Option 2: Docker Run (Basic customization)**
```bash
# Build the image directly from GitHub repository
docker build -t coming-soon https://github.com/yiddytlq/coming-soon.git

# Run with custom configuration
docker run -d -p 8080:80 \
  -e SITE_TITLE="Your Company - Coming Soon" \
  -e BRAND_NAME="YOUR COMPANY" \
  -e SITE_MESSAGE="We're building something amazing!" \
  -e SITE_URL="https://yoursiteurl.com" \
  -e OG_IMAGE="https://yoursiteurl.com/social-image.jpg" \
  coming-soon
```

## Configuration

### Essential Variables
| Variable | Description | Example |
|----------|-------------|---------|
| `SITE_TITLE` | Page title (browser tab) | "ACME Corp - Coming Soon" |
| `BRAND_NAME` | Your brand name | "ACME" |
| `SITE_MESSAGE` | Main message to visitors | "Revolutionary products coming soon!" |

### SEO and Social Media Variables
| Variable | Description | Example |
|----------|-------------|---------|
| `SITE_DESCRIPTION` | SEO meta description | "Revolutionary products are coming soon!" |
| `SITE_URL` | Canonical URL and base for social sharing | "https://yourcompany.com" |
| `OG_IMAGE` | Open Graph image for social sharing | "https://yourcompany.com/social-image.jpg" |
| `OG_TYPE` | Open Graph content type | "website" |

### Optional Customization
| Variable | Description | Default |
|----------|-------------|---------|
| `SITE_KEYWORDS` | SEO meta keywords | "coming soon, template, website, launch" |
| `CUSTOM_LOGO_URL` | Custom logo image URL | _(none)_ |
| `CUSTOM_CSS_URL` | Custom stylesheet URL | _(none)_ |
| `BACKGROUND_VIDEO` | Background video path/URL | "./media/bgvideo1.mp4" |

For a complete list of configuration options, see `.env.example`.

## Documentation

📖 **[DOCKER.md](DOCKER.md)** - Complete Docker deployment guide with advanced examples  

## Browser Support

Modern browsers (Chrome, Firefox, Safari, Edge) with responsive design for mobile and tablet devices.