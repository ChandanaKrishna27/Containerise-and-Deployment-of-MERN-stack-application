# ---------- Build client (React/Vite/CRA) ----------
FROM node:18 AS client
WORKDIR /app
COPY client/package*.json ./client/
RUN cd client && (npm ci || npm install)
COPY client ./client
RUN cd client && npm run build --if-present

# ---------- Install backend (Node/Express) ----------
FROM node:18 AS backend
WORKDIR /app
COPY backend/package*.json ./backend/
RUN cd backend && (npm ci --omit=dev || npm install --omit=dev)
COPY backend ./backend

# ---------- Final image ----------
FROM node:18
WORKDIR /app

# Copy backend
COPY --from=backend /app/backend ./backend

# Copy client build (support both Vite 'dist' and CRA 'build')
COPY --from=client /app/client /client
RUN mkdir -p ./backend/public && \
    if [ -d /client/dist ]; then cp -r /client/dist/* ./backend/public/; \
    elif [ -d /client/build ]; then cp -r /client/build/* ./backend/public/; \
    else echo "No client build output found (dist or build) — serving backend only"; fi

ENV PORT=4000
EXPOSE 4000
WORKDIR /app/backend
CMD ["npm","start"]
