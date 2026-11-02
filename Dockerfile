# War of the States — browser game (Three.js) + thin WebSocket relay
# Players open a URL; the host browser is authoritative. This container only
# serves static files and relays room traffic.
FROM node:20-alpine
WORKDIR /app
COPY server/package.json server/package-lock.json ./server/
WORKDIR /app/server
RUN npm ci --omit=dev || npm install --omit=dev
COPY server/index.js ./
COPY prototype /app/prototype
ENV PORT=8787
EXPOSE 8787
CMD ["node", "index.js"]
