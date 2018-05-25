# PRETTY_NAME="Debian GNU/Linux 8 (jessie)"
# VERSION="8 (jessie)"
#
FROM node:carbon

ARG TAG
LABEL TAG=${TAG}

# https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
LABEL maintainer="mzum <mzum@mzum.org>"

ENV NODE_JS_VERSION 0.0.0
ENV TINI_VERSION v0.18.0

# Update APT
RUN set -ex; \
    apt-get dist-upgrade -yu; \
    apt-get dist-upgrade -yu; \
    apt-get dist-upgrade -yu;

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
    && gpg --verify /tini.asc
 
# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

COPY entrypoint.sh /
RUN chmod +x /tini


EXPOSE 8080

ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
CMD [ "npm", "start" ]
#
