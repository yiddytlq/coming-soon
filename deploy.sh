#!/bin/bash

# Coming Soon Template Deployment Script
# This script replaces template variables with environment variables or default values

# Set default values if environment variables are not set
SITE_TITLE=${SITE_TITLE:-"Coming Soon"}
SITE_DESCRIPTION=${SITE_DESCRIPTION:-"Coming soon page template - customize this description"}
SITE_KEYWORDS=${SITE_KEYWORDS:-"coming soon, template, website, launch"}
BRAND_NAME=${BRAND_NAME:-"NEXUS"}
SITE_MESSAGE=${SITE_MESSAGE:-"Hello fellow developers! We're currently building our new application. Stay up-to-date with announcements and our launch date."}
BACKGROUND_VIDEO=${BACKGROUND_VIDEO:-"./media/bgvideo1.mp4"}
FAVICON=${FAVICON:-"media/hourglass.png"}

# Create a copy of the template for deployment
cp index.html index-deployed.html

# Replace template variables
sed -i "s/{{SITE_TITLE}}/$SITE_TITLE/g" index-deployed.html
sed -i "s/{{SITE_DESCRIPTION}}/$SITE_DESCRIPTION/g" index-deployed.html
sed -i "s/{{SITE_KEYWORDS}}/$SITE_KEYWORDS/g" index-deployed.html
sed -i "s/{{BRAND_NAME}}/$BRAND_NAME/g" index-deployed.html
sed -i "s|{{SITE_MESSAGE}}|$SITE_MESSAGE|g" index-deployed.html
sed -i "s|{{BACKGROUND_VIDEO}}|$BACKGROUND_VIDEO|g" index-deployed.html
sed -i "s|{{FAVICON}}|$FAVICON|g" index-deployed.html

echo "Deployment file created: index-deployed.html"
echo "Template variables replaced with:"
echo "  SITE_TITLE: $SITE_TITLE"
echo "  SITE_DESCRIPTION: $SITE_DESCRIPTION"
echo "  SITE_KEYWORDS: $SITE_KEYWORDS"
echo "  BRAND_NAME: $BRAND_NAME"
echo "  SITE_MESSAGE: $SITE_MESSAGE"
echo "  BACKGROUND_VIDEO: $BACKGROUND_VIDEO"
echo "  FAVICON: $FAVICON"