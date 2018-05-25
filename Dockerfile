# PRETTY_NAME="Debian GNU/Linux 8 (jessie)"
# VERSION="8 (jessie)"
#
FROM node:carbon

ARG TAG
LABEL TAG=${TAG}

# https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
LABEL maintainer="mzum <mzum@mzum.org>"

ENV NODE_JS_VERSION 1.0.0

# Update APT
RUN set -ex; \
    apt-get dist-upgrade -yu; \
    apt-get dist-upgrade -yu; \
    apt-get dist-upgrade -yu;

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=productionstash-entrypoint.sh

# Bundle app source
COPY . .

COPY entrypoint.sh /

EXPOSE 8080

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD [ "npm", "start" ]
#
