#!/bin/sh
set -e

# Function to safely escape special characters for sed
escape_for_sed() {
    echo "$1" | sed 's/[[\.*^$()+?{|]/\\&/g'
}

# Function to download file from URL
download_custom_asset() {
    local url="$1"
    local destination="$2"
    
    if [ -n "$url" ]; then
        echo "Downloading custom asset from: $url"
        if wget -q --spider "$url"; then
            wget -q -O "$destination" "$url" || echo "Warning: Failed to download $url"
        else
            echo "Warning: URL $url is not accessible"
        fi
    fi
}

echo "Starting Coming Soon application with Docker..."

# Copy template to working directory
cp /usr/share/nginx/html/index-template.html /usr/share/nginx/html/index.html

# Set default values (already set via ENV in Dockerfile, but fallback here)
SITE_TITLE=${SITE_TITLE:-"Coming Soon"}
SITE_DESCRIPTION=${SITE_DESCRIPTION:-"Coming Soon - We're building something amazing"}
SITE_KEYWORDS=${SITE_KEYWORDS:-"coming soon, template, website, launch"}
SITE_URL=${SITE_URL:-"https://example.com"}
OG_IMAGE=${OG_IMAGE:-"https://example.com/media/hourglass.png"}
OG_TYPE=${OG_TYPE:-"website"}
BRAND_NAME=${BRAND_NAME:-"NEXUS"}
SITE_MESSAGE=${SITE_MESSAGE:-"Hello fellow developers! We're currently building our new application. Stay up-to-date with announcements and our launch date."}
BACKGROUND_VIDEO=${BACKGROUND_VIDEO:-"./media/bgvideo1.mp4"}
FAVICON=${FAVICON:-"media/hourglass.png"}

# Process template with environment variables
echo "Configuring application with environment variables..."
sed -i "s|{{SITE_TITLE}}|$(escape_for_sed "$SITE_TITLE")|g" /usr/share/nginx/html/index.html
sed -i "s|{{SITE_DESCRIPTION}}|$(escape_for_sed "$SITE_DESCRIPTION")|g" /usr/share/nginx/html/index.html
sed -i "s|{{SITE_KEYWORDS}}|$(escape_for_sed "$SITE_KEYWORDS")|g" /usr/share/nginx/html/index.html
sed -i "s|{{SITE_URL}}|$(escape_for_sed "$SITE_URL")|g" /usr/share/nginx/html/index.html
sed -i "s|{{OG_IMAGE}}|$(escape_for_sed "$OG_IMAGE")|g" /usr/share/nginx/html/index.html
sed -i "s|{{OG_TYPE}}|$(escape_for_sed "$OG_TYPE")|g" /usr/share/nginx/html/index.html
sed -i "s|{{BRAND_NAME}}|$(escape_for_sed "$BRAND_NAME")|g" /usr/share/nginx/html/index.html
sed -i "s|{{SITE_MESSAGE}}|$(escape_for_sed "$SITE_MESSAGE")|g" /usr/share/nginx/html/index.html
sed -i "s|{{BACKGROUND_VIDEO}}|$(escape_for_sed "$BACKGROUND_VIDEO")|g" /usr/share/nginx/html/index.html
sed -i "s|{{FAVICON}}|$(escape_for_sed "$FAVICON")|g" /usr/share/nginx/html/index.html

# Handle custom CSS override
if [ -n "$CUSTOM_CSS_URL" ]; then
    echo "Custom CSS URL provided: $CUSTOM_CSS_URL"
    download_custom_asset "$CUSTOM_CSS_URL" "/usr/share/nginx/html/custom/custom.css"
    # Inject custom CSS into the HTML
    sed -i 's|</head>|  <link rel="stylesheet" href="/custom/custom.css">\n</head>|' /usr/share/nginx/html/index.html
fi

# Handle custom logo override
if [ -n "$CUSTOM_LOGO_URL" ]; then
    echo "Custom logo URL provided: $CUSTOM_LOGO_URL"
    download_custom_asset "$CUSTOM_LOGO_URL" "/usr/share/nginx/html/custom/logo.png"
    # Replace the brand name with logo image in HTML
    sed -i 's|<span style="font-size: 2rem; color: white;" id="brand-name">.*</span>|<img class="logo" src="/custom/logo.png" alt="Logo" style="height: 3rem; max-width: 200px;" />|' /usr/share/nginx/html/index.html
fi

echo "Configuration complete! Application ready."
echo "Environment variables applied:"
echo "  SITE_TITLE: $SITE_TITLE"
echo "  SITE_DESCRIPTION: $SITE_DESCRIPTION"
echo "  SITE_KEYWORDS: $SITE_KEYWORDS"
echo "  SITE_URL: $SITE_URL"
echo "  OG_IMAGE: $OG_IMAGE"
echo "  OG_TYPE: $OG_TYPE"
echo "  BRAND_NAME: $BRAND_NAME"
echo "  SITE_MESSAGE: $SITE_MESSAGE"
echo "  BACKGROUND_VIDEO: $BACKGROUND_VIDEO"
echo "  FAVICON: $FAVICON"

if [ -n "$CUSTOM_CSS_URL" ]; then
    echo "  CUSTOM_CSS_URL: $CUSTOM_CSS_URL"
fi

if [ -n "$CUSTOM_LOGO_URL" ]; then
    echo "  CUSTOM_LOGO_URL: $CUSTOM_LOGO_URL"
fi

# Execute the main command
exec "$@"