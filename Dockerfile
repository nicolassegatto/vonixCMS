FROM directus/directus:latest

# Copy custom extensions
COPY ./extensions /directus/extensions

# Install dependencies for extensions (if any)
WORKDIR /directus/extensions
RUN if [ -d "/directus/extensions" ]; then for dir in */; do if [ -f "$dir/package.json" ]; then cd "$dir" && npm install && cd ..; fi; done; fi

# Set working directory back to Directus
WORKDIR /directus

# Expose port
EXPOSE 8055