#!/bin/bash

# Coming Soon Template Deployment Script
# This script replaces template variables with environment variables or default values

# Set default values if environment variables are not set
SITE_TITLE=${SITE_TITLE:-"Coming Soon"}
SITE_DESCRIPTION=${SITE_DESCRIPTION:-"Coming soon page template - customize this description"}
SITE_KEYWORDS=${SITE_KEYWORDS:-"coming soon, template, website, launch"}
BRAND_NAME=${BRAND_NAME:-"YOUR BRAND"}
SITE_MESSAGE=${SITE_MESSAGE:-"We're working on something amazing! Stay tuned for our launch."}

# Create a copy of the template for deployment
cp index.html index-deployed.html

# Replace template variables
sed -i "s/{{SITE_TITLE}}/$SITE_TITLE/g" index-deployed.html
sed -i "s/{{SITE_DESCRIPTION}}/$SITE_DESCRIPTION/g" index-deployed.html
sed -i "s/{{SITE_KEYWORDS}}/$SITE_KEYWORDS/g" index-deployed.html
sed -i "s/{{BRAND_NAME}}/$BRAND_NAME/g" index-deployed.html
sed -i "s|{{SITE_MESSAGE}}|$SITE_MESSAGE|g" index-deployed.html

echo "Deployment file created: index-deployed.html"
echo "Template variables replaced with:"
echo "  SITE_TITLE: $SITE_TITLE"
echo "  SITE_DESCRIPTION: $SITE_DESCRIPTION"
echo "  SITE_KEYWORDS: $SITE_KEYWORDS"
echo "  BRAND_NAME: $BRAND_NAME"
echo "  SITE_MESSAGE: $SITE_MESSAGE"