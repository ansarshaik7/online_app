# First Stage

# Base Image for node js
FROM node:24-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy the code files
COPY package*.json ./

# Run the dependency files
RUN npm ci

# Copy the code files
COPY . .

# Run the dependency files
RUN npm run build

# Second Stage

# BASE image for node js
FROM nginx:alpine

# Work Directory
WORKDIR /usr/share/nginx/html

# Copy files 
COPY --from=builder /app/dist ./
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose Port
EXPOSE 80

# Run CMD
CMD ["nginx", "-g", "daemon off;"]


