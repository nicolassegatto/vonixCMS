FROM directus/directus:latest

# Switch to root user to adjust permissions
USER root
# Ensure the extensions directory exists and is owned by the node user
RUN mkdir -p /directus/extensions && chown -R node:node /directus/extensions

# Copy custom extensions
COPY --chown=node:node ./extensions /directus/extensions

# Switch back to node user for security
USER node
# Install and build extensions (if any)
WORKDIR /directus/extensions
RUN if [ -d "/directus/extensions" ]; then for dir in */; do if [ -f "$dir/package.json" ]; then cd "$dir" && npm install && npm run build && cd ..; fi; done; fi

# Set working directory back to Directus
WORKDIR /directus

# Expose port
EXPOSE 8055