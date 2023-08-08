FROM node:20 as api-builder

WORKDIR /usr/src/app

COPY package*.json ./
COPY ./tsconfig*.json .
COPY ./nest-cli.json .
COPY ./tslint.json .
COPY ./src ./src

RUN npm ci
RUN npm run build

FROM node:20

WORKDIR /usr/src/server

COPY --from=api-builder /usr/src/api/dist ./dist
COPY --from=api-builder /usr/src/api/package.json .
COPY --from=api-builder /usr/src/api/node_modules ./node_modules

COPY ./static ./static
COPY ./templates ./templates
COPY ./locales ./locales

EXPOSE 3000

CMD ["node dist/main.js"]
