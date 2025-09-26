# Coming Soon Page Template

A responsive coming soon page template that can be easily customized for any brand or project.

## Features

- Responsive design that works on all devices
- Video background support
- Clean, modern design
- Easy to customize with environment variables or template placeholders

## Customization

The template uses placeholder variables that can be replaced during deployment:

### Template Variables

- `{{SITE_TITLE}}` - The page title shown in browser tab
- `{{SITE_DESCRIPTION}}` - Meta description for SEO
- `{{SITE_KEYWORDS}}` - Meta keywords for SEO
- `{{BRAND_NAME}}` - Your brand/company name
- `{{SITE_MESSAGE}}` - Main message displayed to visitors

### Default Values

See `template-config.json` for default values that you can customize. The template uses "NEXUS" as a fictional brand name and preserves the original non-brand-specific content.

**Note:** Brand names are automatically formatted with spaces between letters (e.g., "NEXUS" becomes "N E X U S") to match the original design aesthetic. If your brand name already contains spaces, they will be preserved as-is.

### Deployment Options

#### Option 1: Direct Replacement
Replace template variables directly in the HTML file before deployment.

#### Option 2: Environment Variables + Build Script
Create a build script that replaces template variables with environment variables:

```bash
# Example environment variables
export SITE_TITLE="My Awesome Site"
export BRAND_NAME="ACME Corp"
export SITE_MESSAGE="Something amazing is coming soon!"

# Replace in HTML file
sed -i 's/{{SITE_TITLE}}/'$SITE_TITLE'/g' index.html
sed -i 's/{{BRAND_NAME}}/'$BRAND_NAME'/g' index.html
sed -i 's/{{SITE_MESSAGE}}/'$SITE_MESSAGE'/g' index.html
```

#### Option 3: CI/CD Pipeline
Use your CI/CD pipeline to inject values during build/deployment process.

## Files Structure

- `index.html` - Main HTML template with placeholder variables
- `styles.css` - CSS styles (no customization needed)
- `app.js` - JavaScript for email validation (currently commented out)
- `images/` - Background video and icons
- `template-config.json` - Default configuration values
- `README.md` - This documentation

## Usage

1. Clone or download this template
2. Replace template variables with your values
3. Customize the background video in `images/bgvideo1.mp4` if needed
4. Deploy to your web server

## Background Video

The template includes a background video (`images/bgvideo1.mp4`). Replace this with your own video file to match your brand aesthetic.

## Browser Support

- Modern browsers (Chrome, Firefox, Safari, Edge)
- Responsive design for mobile and tablet devices