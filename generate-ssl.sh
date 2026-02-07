#!/bin/bash
# Generate self-signed SSL certificates for development/testing
# For production, use Let's Encrypt or a trusted CA

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SSL_DIR="$SCRIPT_DIR/nginx/ssl"

# Create SSL directory
mkdir -p "$SSL_DIR"

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$SSL_DIR/key.pem" \
    -out "$SSL_DIR/cert.pem" \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

echo "✅ SSL certificates generated successfully!"
echo "   Certificate: $SSL_DIR/cert.pem"
echo "   Private Key: $SSL_DIR/key.pem"
echo ""
echo "⚠️  These are self-signed certificates for development only."
echo "   For production, use Let's Encrypt or a trusted Certificate Authority."
echo ""
echo "To start the app with HTTPS:"
echo "   docker compose up -d"
echo ""
echo "Access the app at: https://localhost"
