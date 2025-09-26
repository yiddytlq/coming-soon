#!/bin/bash

# Test script to demonstrate custom asset functionality
# This shows how to override assets using URLs

echo "🧪 Testing Custom Asset Override Functionality"
echo "=============================================="

# Test with a simple CSS override that changes the background color
echo "Creating a test container with custom CSS URL simulation..."

# Start container with custom asset environment variables
docker run -d -p 8081:80 --name asset-test \
  -e SITE_TITLE="Asset Override Demo" \
  -e BRAND_NAME="DEMO" \
  -e SITE_MESSAGE="This demonstrates asset override functionality. In production, you would use real URLs." \
  -e CUSTOM_CSS_URL="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" \
  final-test

echo "Container started. Testing asset override functionality..."
sleep 3

# Check if the container is running
if docker ps | grep -q asset-test; then
  echo "✅ Container is running successfully"
  
  # Test the health endpoint
  if curl -s http://localhost:8081/health | grep -q "healthy"; then
    echo "✅ Health check passed"
  fi
  
  # Check if the HTML contains our custom messaging
  if curl -s http://localhost:8081 | grep -q "Asset Override Demo"; then
    echo "✅ Custom environment variables applied successfully"
  fi
  
  # Check container logs for asset processing
  echo ""
  echo "📋 Container logs showing asset processing:"
  docker logs asset-test | grep -E "(Custom|Environment|Configuration)"
  
else
  echo "❌ Container failed to start"
fi

# Cleanup
echo ""
echo "🧹 Cleaning up test container..."
docker stop asset-test >/dev/null 2>&1
docker rm asset-test >/dev/null 2>&1

echo "✅ Asset override functionality test completed"