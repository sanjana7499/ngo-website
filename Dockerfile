# Use Ubuntu as base image
FROM ubuntu:latest

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Copy files from host to container
COPY . /myweb/

# Set working directory
WORKDIR /myweb

# Expose port 80 for NGINX
EXPOSE 80

# Start NGINX when the container runs
CMD ["nginx", "-g", "daemon off;"]
