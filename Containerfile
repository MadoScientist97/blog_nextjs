FROM ubuntu:noble

USER root
RUN apt update && apt upgrade -y
RUN apt install -y curl git
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs

RUN mkdir /blog

WORKDIR /blog

RUN npm install -g yarn
RUN yarn add next react react-dom nextra nextra-theme-blog

COPY next.config.js next.config.js
COPY theme.config.jsx theme.config.jsx

EXPOSE 3000

CMD [ "yarn", "run", "next" ]
