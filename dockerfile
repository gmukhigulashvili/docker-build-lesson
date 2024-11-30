# Use the latest Node.js LTS version as the base image
FROM node:lts-slim
# Create a non-root user and group with UID and GID 1002
RUN groupadd -g 1002 appuser && useradd -u 1002 -g appuser -m appuser

# Set the working directory to the app root
WORKDIR /app

# Copy the package.json and package-lock.json files from the service1 directory
COPY package*.json .

# Install the dependencies
RUN npm install

# Copy the rest of the service1 application code
COPY . /app

# Change ownership of the app directory to the non-root user
RUN chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

# Expose the port your app will run on (adjust as necessary)
EXPOSE 3000

# Start the application from the correct directory
CMD ["node", "index.js"]

