FROM node:20 as api-builder

WORKDIR /usr/src/app

COPY package*.json ./
COPY ./tsconfig*.json .
COPY ./nest-cli.json .
COPY ./src ./src

RUN npm ci
RUN npm run build

FROM node:20

WORKDIR /usr/src/server

COPY --from=api-builder /usr/src/app/dist ./dist
COPY --from=api-builder /usr/src/app/package.json .
COPY --from=api-builder /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["node dist/main.js"]
