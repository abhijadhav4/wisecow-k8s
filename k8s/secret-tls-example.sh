#!/usr/bin/env bash
# Usage: ./secret-tls-example.sh <namespace> <secret-name> <cert-file> <key-file>

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <namespace> <secret-name> <tls.crt> <tls.key>"
  exit 1
fi

# Create the namespace if not exists (dry-run client generates YAML which is applied)
kubectl create namespace "$1" --dry-run=client -o yaml | kubectl apply -f -

# Create TLS secret in the specified namespace with the provided cert and key files
kubectl create secret tls "$2" -n "$1" --cert="$3" --key="$4"
