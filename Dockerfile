FROM nginx:latest
WORKDIR /opt
COPY . /usr/share/nginx/html
RUN sudo apt-get update
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
