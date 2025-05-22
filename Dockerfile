FROM directus/directus:latest

# Switch to root user to adjust permissions
USER root
RUN chown -R node:node /directus/extensions

# Copy custom extensions
COPY ./extensions /directus/extensions

# Switch back to node user for security
USER node
# Install dependencies for extensions (if any)
WORKDIR /directus/extensions
RUN if [ -d "/directus/extensions" ]; then for dir in */; do if [ -f "$dir/package.json" ]; then cd "$dir" && npm install && npm run build && cd ..; fi; done; fi

# Set working directory back to Directus
WORKDIR /directus

# Expose port
EXPOSE 8055