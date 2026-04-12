ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-alpine

WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

RUN npm run docs:build

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENTRYPOINT ["npm", "run", "docs:preview"]
