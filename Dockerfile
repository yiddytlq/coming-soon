# Production build for Coming Soon application
FROM nginx:alpine

# Copy source files to nginx html directory
COPY index.html /usr/share/nginx/html/index-template.html
COPY styles.css /usr/share/nginx/html/
COPY app.js /usr/share/nginx/html/
COPY media/ /usr/share/nginx/html/media/

# Create directory for custom assets
RUN mkdir -p /usr/share/nginx/html/custom

# Copy nginx configuration
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Create entrypoint script for runtime template processing
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Set environment variables with defaults
ENV SITE_TITLE="Coming Soon" \
    SITE_DESCRIPTION="Coming Soon - We're building something amazing" \
    SITE_KEYWORDS="coming soon, template, website, launch" \
    SITE_URL="https://example.com" \
    OG_IMAGE="https://example.com/media/hourglass.png" \
    OG_TYPE="website" \
    BRAND_NAME="NEXUS" \
    SITE_MESSAGE="Hello fellow developers! We're currently building our new application. Stay up-to-date with announcements and our launch date." \
    BACKGROUND_VIDEO="./media/bgvideo1.mp4" \
    FAVICON="media/hourglass.png" \
    CUSTOM_CSS_URL="" \
    CUSTOM_LOGO_URL=""

# Expose port 80
EXPOSE 80

# Use custom entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]