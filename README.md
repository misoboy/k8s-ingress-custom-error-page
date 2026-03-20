# k8s-ingress-custom-error-page

> Custom error page server for Kubernetes **nginx-ingress** with Prometheus metrics support.

[![Go](https://img.shields.io/badge/Go-1.x-00ADD8?logo=go&logoColor=white)](https://golang.org)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-nginx--ingress-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io)
[![Prometheus](https://img.shields.io/badge/Prometheus-metrics-E6522C?logo=prometheus&logoColor=white)](https://prometheus.io)
[![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)](https://docker.com)

## Overview

This project provides a custom **default backend** service for the Kubernetes nginx-ingress controller. When nginx cannot route a request (404, 503, etc.), it forwards it to this service, which returns a user-friendly error page.

Features:
- Serves custom HTML error pages based on HTTP status code and content format
- Exposes **Prometheus metrics** (request counts, latencies)
- Supports `X-Format` and `X-Code` headers from nginx-ingress
- Lightweight Go HTTP server

## Project Structure

```
.
├── main.go         # HTTP server and error page handler
├── metrics.go      # Prometheus metrics definitions
├── Dockerfile      # Container image
├── k8s/            # Kubernetes deployment manifests
└── rootfs/         # Static error page templates (HTML, JSON, text)
```

## Getting Started

### Docker

```bash
docker build -t k8s-ingress-custom-error-page .
docker run -p 8080:8080 k8s-ingress-custom-error-page
```

### Deploy to Kubernetes

```bash
kubectl apply -f k8s/
```

### Configure nginx-ingress

```yaml
# values.yaml (nginx-ingress Helm chart)
defaultBackend:
  enabled: false

controller:
  extraArgs:
    default-backend-service: "your-namespace/k8s-ingress-custom-error-page"
```

## Metrics

Prometheus metrics are exposed at `/metrics`:

| Metric | Description |
|--------|-------------|
| `http_requests_total` | Total HTTP requests by status code |
| `http_request_duration_seconds` | Request latency histogram |

## License

Apache 2.0 (based on Kubernetes Authors original work)

