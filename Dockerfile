# Dockerfile for "Codin 1" website development environment using Create React App
# Base: Node.js LTS on Alpine for a small image
FROM node:20-alpine

# Build args so the WORKDIR follows the required "lastName_firstName_site" pattern
ARG LASTNAME=Brajkovich
ARG FIRSTNAME=Brandan

# Required workdir name per assignment
WORKDIR /usr/src/${LASTNAME}_${FIRSTNAME}_site

# Environment for CRA dev server
ENV PORT=7775
ENV HOST=0.0.0.0
# Enable polling so file watching works well in containers across OSes
ENV CHOKIDAR_USEPOLLING=true

# Install app dependencies
COPY package.json package-lock.json* ./
RUN npm ci --no-audit --no-fund || npm install --no-audit --no-fund

# Copy app source
COPY public ./public
COPY src ./src

# Expose the dev server port
EXPOSE 7775

# Run the Create React App dev server
CMD ["npm", "start"]
