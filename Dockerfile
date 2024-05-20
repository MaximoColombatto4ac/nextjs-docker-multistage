# FROM node:alpine

# WORKDIR /app/

# COPY ./my-app/ /app/

# RUN npm install

# ENTRYPOINT [ "npm", "run", "dev" ]

FROM node:alpine as build
WORKDIR /app
COPY ./my-app/package*.json ./
RUN npm install
COPY ./my-app/ .
RUN npm run build 

FROM nginx:alpine
COPY --from=build /app/.next/ /_next/
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY  ./my-app/public /_next/server/app
EXPOSE 80