FROM node:20-alpine AS base

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --omit=dev

COPY prisma ./prisma/

RUN npx prisma generate

FROM node:20-alpine

WORKDIR /usr/src/app

COPY --from=base /usr/src/app/node_modules ./node_modules
COPY --from=base /usr/src/app/prisma ./prisma

COPY . .

EXPOSE 8080

CMD ["sh", "-c", "npx prisma migrate deploy && node src/server.js"]
