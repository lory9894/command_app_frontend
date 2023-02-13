#builder container for client
FROM cirrusci/flutter as builder_client

RUN mkdir /app/
COPY cliente /app/
WORKDIR /app/

RUN flutter create .
RUN flutter config --enable-web
RUN flutter build web --base-href "/cliente/"

#builder container for gestor
FROM cirrusci/flutter as builder_gestor

RUN mkdir /app/
COPY gestore /app/
WORKDIR /app/

RUN flutter create .
RUN flutter config --enable-web
RUN flutter build web --base-href "/gestore/"

#production container
FROM ubuntu:20.04

# Set environment variables
# This is used to avoid user interaction during installation
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN mkdir /app/
COPY ./server/ /app/server/
COPY --from=builder_client /app/build/web/ /app/cliente/
COPY --from=builder_gestor /app/build/web/ /app/gestore/
WORKDIR /app/

# Record the exposed port, you should read the README.md to know which port to expose
EXPOSE 80

# make server startup script executable and start the web server
RUN ["chmod", "+x", "server/server.sh"]

ENTRYPOINT [ "server/server.sh"]

