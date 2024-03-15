# Use the latest Node.js LTS version as the base image
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose port 3000 for the HTTP server
EXPOSE 3000

# Start the HTTP server when the container starts
CMD ["node", "index.js"]
