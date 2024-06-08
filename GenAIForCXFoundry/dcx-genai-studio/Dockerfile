# Start with the official Node.js image       
FROM node:16-alpine  

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY dcx-genai-dev-studion/package*.json ./

# Clear npm cache
RUN npm cache clean --force

# Install dependencies
RUN npm install

# Copy the rest of your app's source code
COPY dcx-genai-dev-studion/ ./

# Build the Next.js app
RUN NEXT_PUBLIC_API_URL=APP_NEXT_PUBLIC_API_URL npm run build

COPY  dcx-genai-dev-studion/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# Add user and group for running the application
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

# Change ownership to the non-root user
RUN chown -R nextjs:nodejs /app

# Use the non-root user to run our application
USER nextjs

# Expose port 3000 (if needed)
EXPOSE 3000


ENTRYPOINT ["/app/entrypoint.sh"]

# Start the app
CMD ["npm", "start"]
