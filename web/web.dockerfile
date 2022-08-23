# pull the official base image
FROM node:alpine3.11

RUN mkdir -p /app

# set working direction
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV PORT=3000

# install application dependencies
COPY package.json ./
COPY yarn.lock ./

RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
RUN yarn install

EXPOSE 3000

# start app
CMD ["yarn", "dev"]