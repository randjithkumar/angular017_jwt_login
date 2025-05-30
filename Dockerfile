# Stage 1: Build the Angular app
FROM node:22-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm install
RUN ls -ltr *
COPY . .
RUN npm run build -- --configuration production

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built files from previous stage
#COPY --from=build /app/dist/* /usr/share/nginx/html/
COPY --from=build /app/dist/angular-17-jwt-auth/browser /usr/share/nginx/html/
# Expose port 80
EXPOSE 81

CMD ["nginx", "-g", "daemon off;"]
