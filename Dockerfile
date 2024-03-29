FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx as runner
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html