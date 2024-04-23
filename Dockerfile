# Use the official NGINX image as the base image
FROM nginx

# Copy the website files into the NGINX web root directory
COPY . /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# Command to start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
