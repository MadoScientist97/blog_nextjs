ARG NODE_VERSION=18
ARG ALPINE_VERSION=latest

FROM node:${NODE_VERSION}-alpine AS node

FROM alpine:${ALPINE_VERSION}

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

RUN mkdir /blog
WORKDIR /blog

RUN npm install -g yarn --force
RUN yarn add next react react-dom nextra nextra-theme-blog

COPY next.config.js next.config.js
COPY theme.config.jsx theme.config.jsx

EXPOSE 3000

CMD [ "yarn", "run", "next" ]
