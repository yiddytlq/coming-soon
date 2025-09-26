#!/bin/bash

# Docker Deployment Examples for Coming Soon Application
# This script demonstrates various ways to deploy the application using Docker

echo "🐳 Coming Soon Application - Docker Deployment Examples"
echo "=================================================="

# Example 1: Basic deployment
echo "📋 Example 1: Basic deployment with default settings"
echo "docker run -d -p 8080:80 --name coming-soon-basic coming-soon"
echo ""

# Example 2: Custom branding
echo "📋 Example 2: Custom branding and messaging"
cat << 'EOF'
docker run -d -p 8080:80 --name coming-soon-custom \
  -e SITE_TITLE="ACME Corporation - Coming Soon" \
  -e BRAND_NAME="ACME CORP" \
  -e SITE_MESSAGE="We're revolutionizing the industry. Something incredible is coming your way!" \
  -e SITE_DESCRIPTION="ACME Corporation is launching something revolutionary" \
  -e SITE_KEYWORDS="ACME, innovation, technology, corporate, launch" \
  --restart unless-stopped \
  coming-soon
EOF
echo ""

# Example 3: Startup with external assets
echo "📋 Example 3: Startup with custom assets from CDN"
cat << 'EOF'
docker run -d -p 8080:80 --name coming-soon-startup \
  -e SITE_TITLE="TechStart - Launching Soon" \
  -e BRAND_NAME="TechStart" \
  -e SITE_MESSAGE="We're building the future of technology. Join us on this incredible journey!" \
  -e CUSTOM_LOGO_URL="https://cdn.techstart.com/logo.png" \
  -e CUSTOM_CSS_URL="https://cdn.techstart.com/brand.css" \
  -e BACKGROUND_VIDEO="https://cdn.techstart.com/hero-video.mp4" \
  --restart unless-stopped \
  coming-soon
EOF
echo ""

# Example 4: With local asset mounting
echo "📋 Example 4: With local asset mounting"
cat << 'EOF'
# First create your custom assets directory
mkdir -p ./custom-assets
# Add your custom logo, CSS, etc. to ./custom-assets/

docker run -d -p 8080:80 --name coming-soon-mounted \
  -e SITE_TITLE="My Company - Coming Soon" \
  -e BRAND_NAME="MY COMPANY" \
  -v ./custom-assets:/usr/share/nginx/html/custom:ro \
  coming-soon
EOF
echo ""

# Example 5: Docker Compose
echo "📋 Example 5: Using Docker Compose"
cat << 'EOF'
# Create .env file with your configuration
cat > .env << EOL
SITE_TITLE=My Amazing Product
BRAND_NAME=AMAZING
SITE_MESSAGE=Get ready for something that will change everything!
SITE_DESCRIPTION=Amazing Product - Revolutionary platform coming soon
SITE_KEYWORDS=amazing, product, revolutionary, platform
CUSTOM_LOGO_URL=https://cdn.mycompany.com/logo.png
EOL

# Deploy with docker-compose
docker compose up -d
EOF
echo ""

# Example 6: Production deployment with reverse proxy
echo "📋 Example 6: Production deployment with Traefik reverse proxy"
cat << 'EOF'
# docker-compose.production.yml
version: '3.8'
services:
  coming-soon:
    image: coming-soon
    environment:
      - SITE_TITLE=Example.com - Coming Soon
      - BRAND_NAME=EXAMPLE
      - SITE_MESSAGE=Something revolutionary is coming to example.com
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.coming-soon.rule=Host(\`example.com\`)"
      - "traefik.http.routers.coming-soon.tls.certresolver=letsencrypt"
    networks:
      - traefik

networks:
  traefik:
    external: true
EOF
echo ""

echo "🔧 Useful Commands:"
echo "==================="
echo "# View running containers"
echo "docker ps"
echo ""
echo "# Check container logs"  
echo "docker logs <container-name>"
echo ""
echo "# Stop and remove container"
echo "docker stop <container-name> && docker rm <container-name>"
echo ""
echo "# Health check"
echo "curl http://localhost:8080/health"
echo ""

echo "📖 For complete documentation, see DOCKER.md"