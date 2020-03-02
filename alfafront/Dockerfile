FROM node AS build-stage
WORKDIR /app
COPY . .
RUN npm install && npm run build


FROM nginx:stable AS prod-stage
EXPOSE 80
COPY --from=build-stage /app/dist/ /var/www
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
