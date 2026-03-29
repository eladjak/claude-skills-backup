---
description: Docker commands and patterns
---

Docker development helper.

## Quick Commands

```bash
# Build image
docker build -t myapp .

# Run container
docker run -p 3000:3000 myapp

# Run with env
docker run -p 3000:3000 --env-file .env myapp

# List containers
docker ps -a

# Stop container
docker stop <container_id>

# Remove container
docker rm <container_id>

# View logs
docker logs -f <container_id>

# Shell into container
docker exec -it <container_id> /bin/sh
```

## Docker Compose

```bash
# Start all services
docker-compose up -d

# Stop all
docker-compose down

# Rebuild
docker-compose up -d --build

# View logs
docker-compose logs -f

# Run command in service
docker-compose exec app sh
```

## Dockerfile (Node.js)

```dockerfile
FROM node:20-alpine AS base

FROM base AS deps
WORKDIR /app
COPY package.json bun.lockb ./
RUN npm install --frozen-lockfile

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

## docker-compose.yml

```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgres://db:5432/app
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

## Cleanup

```bash
# Remove unused images
docker image prune -a

# Remove all stopped containers
docker container prune

# Full cleanup
docker system prune -a
```
