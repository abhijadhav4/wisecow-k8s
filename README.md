# Wisecow — Containerisation and Kubernetes Deployment

This repository contains the **Wisecow** application and artifacts for containerisation, Kubernetes deployment, and CI/CD automation with TLS support.

---

## 📋 Prerequisites

- Install **fortune** and **cowsay** locally (for development/testing):
  ```bash
  sudo apt install fortune-mod cowsay -y
  ```
- Docker installed locally.
- Kubernetes cluster (Kind, Minikube, or remote cluster).
- `kubectl` configured for your cluster.
- (Optional) Ingress controller (e.g., nginx-ingress) if testing TLS.

---

## 🚀 Usage

### Run locally (without Docker)
```bash
./wisecow.sh
```
Open your browser at `http://localhost:4499`

---

### Run with Docker
```bash
# Build
docker build -t wisecow:latest .

# Run
docker run -p 4499:4499 wisecow:latest
```

Open `http://localhost:4499` in your browser.

---

## ☸️ Kubernetes Deployment

### 1. Apply namespace, deployment, and service
```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### 2. Verify resources
```bash
kubectl -n wisecow get pods
kubectl -n wisecow get svc wisecow-svc
```

Service is exposed on **port 80** inside the cluster.

---

## 🔒 TLS Support (Challenge Goal)

### Option A — Using a pre-created TLS Secret
```bash
./k8s/secret-tls-example.sh wisecow wisecow-tls tls.crt tls.key
kubectl apply -f k8s/ingress-tls-example.yaml
```

Access the app via `https://wisecow.example.local` (adjust `/etc/hosts`).

### Option B — Using cert-manager
- Install cert-manager in your cluster.
- Create an Issuer/ClusterIssuer and Certificate for the ingress host.
- Apply `ingress-tls-example.yaml`.

---

## ⚙️ CI/CD with GitHub Actions

This repository includes `.github/workflows/ci-cd.yml` which:
- Builds and pushes Docker images on every commit to `main`.
- Deploys updated manifests to your Kubernetes cluster.

### Setup GitHub Secrets
Go to **Repository → Settings → Secrets & variables → Actions** and add:
- `REGISTRY_USERNAME` — Registry username (GitHub username for GHCR).
- `REGISTRY_TOKEN` — Personal access token (with `write:packages` for GHCR).
- `IMAGE_NAME` — Full image name, e.g. `ghcr.io/chota_bheem/wisecow`.
- `KUBE_CONFIG` — Base64-encoded kubeconfig.
  ```bash
  cat ~/.kube/config | base64 -w0
  ```

### Trigger workflow
- Push changes to `main` branch, or trigger manually from GitHub Actions tab.

---

## 📂 Repository Layout
```
wisecow/
├─ .github/
│  └─ workflows/
│     └─ ci-cd.yml
├─ k8s/
│  ├─ namespace.yaml
│  ├─ deployment.yaml
│  ├─ service.yaml
│  ├─ ingress-tls-example.yaml
│  └─ secret-tls-example.sh
├─ wisecow.sh
├─ Dockerfile
├─ LICENSE
└─ README.md
```

---

## ✅ End Goal
- Wisecow app runs in Kubernetes.
- Docker image automatically built and deployed via GitHub Actions.
- TLS-enabled Ingress (optional challenge goal).

Enjoy the cow-powered wisdom! 🐄💡

## 🔗 GitHub Repository
Public repo link: [https://github.com/abhijadhav4/wisecow-k8s](https://github.com/abhijadhav4/wisecow-k8s)

