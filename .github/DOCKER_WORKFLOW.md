# Docker Hub Publishing Workflow

This repository includes a GitHub Actions workflow that automatically builds and publishes Docker images to Docker Hub.

## 🚀 Features

- **Automatic Publishing**: Builds and pushes images when changes are pushed to the `main` branch
- **Manual Triggers**: Allows on-demand builds with custom tags via GitHub Actions UI
- **Smart Tagging**: Automatically creates `latest` and commit-based tags
- **Multi-Architecture**: Builds for both `linux/amd64` and `linux/arm64` platforms
- **Optimized Caching**: Uses GitHub Actions cache for faster builds

## 📋 Setup Requirements

### 1. Docker Hub Account
You need a Docker Hub account where the images will be published.

### 2. GitHub Secrets Configuration
Configure the following secrets in your GitHub repository settings (`Settings` → `Secrets and variables` → `Actions`):

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `DOCKER_USERNAME` | Your Docker Hub username | `myusername` |
| `DOCKER_TOKEN` | Docker Hub access token (recommended) or password | `dckr_pat_xxxxxxxxxxxx` |

### 3. Creating a Docker Hub Access Token (Recommended)
Instead of using your Docker Hub password, create an access token:

1. Log in to [Docker Hub](https://hub.docker.com)
2. Go to **Account Settings** → **Security**
3. Click **New Access Token**
4. Give it a name (e.g., "GitHub Actions")
5. Select appropriate permissions (Read, Write, Delete)
6. Copy the generated token and add it as `DOCKER_TOKEN` secret

## 🔄 How It Works

### Automatic Triggers
The workflow runs automatically when:
- Code is pushed to the `main` branch
- Changes don't include only documentation files (`*.md`) or configuration files

### Manual Triggers
You can manually trigger the workflow:
1. Go to **Actions** tab in your GitHub repository
2. Select **Build and Publish Docker Image** workflow
3. Click **Run workflow**
4. Optionally provide a custom tag name

## 🏷️ Tagging Strategy

The workflow creates the following tags automatically:

| Tag Format | When Applied | Example |
|------------|--------------|---------|
| `latest` | Push to main branch | `username/coming-soon:latest` |
| `main-<sha>` | Every build from main | `username/coming-soon:main-abc1234` |
| Custom tag | Manual trigger with custom tag | `username/coming-soon:v1.0.0` |

## 📦 Using Published Images

### Pull the Latest Image
```bash
docker pull yourusername/coming-soon:latest
```

### Run the Container
```bash
# Basic usage
docker run -d -p 8080:80 yourusername/coming-soon:latest

# With custom environment variables
docker run -d -p 8080:80 \
  -e SITE_TITLE="My Company - Coming Soon" \
  -e BRAND_NAME="MY COMPANY" \
  -e SITE_MESSAGE="Something amazing is coming soon!" \
  yourusername/coming-soon:latest
```

### Use in Docker Compose
```yaml
services:
  coming-soon:
    image: yourusername/coming-soon:latest
    ports:
      - "8080:80"
    environment:
      - SITE_TITLE=My Company - Coming Soon
      - BRAND_NAME=MY COMPANY
      - SITE_MESSAGE=Something amazing is coming soon!
    restart: unless-stopped
```

## 🛠️ Workflow Configuration

The workflow file is located at `.github/workflows/docker-publish.yml` and includes:

- **Multi-platform builds** for AMD64 and ARM64 architectures
- **Build caching** to speed up subsequent builds
- **Security best practices** with minimal required permissions
- **Comprehensive logging** and build summaries

## 🚨 Troubleshooting

### Common Issues

**Build fails with authentication error:**
- Verify `DOCKER_USERNAME` and `DOCKER_TOKEN` secrets are correctly set
- Ensure the Docker Hub token has sufficient permissions

**Build fails on specific architecture:**
- Check if your Dockerfile is compatible with multi-architecture builds
- Consider limiting to single architecture if needed

**Image not updating:**
- Verify the workflow triggered correctly in the Actions tab
- Check if changes were made to ignored paths (documentation only)

### Manual Testing
You can test the Docker build locally:
```bash
# Build the image
docker build -t coming-soon-test .

# Test run
docker run -d -p 8080:80 coming-soon-test

# Check it works
curl http://localhost:8080
```

## 📚 Additional Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Hub Access Tokens](https://docs.docker.com/docker-hub/access-tokens/)
- [Project Docker Documentation](./docker/DOCKER.md)