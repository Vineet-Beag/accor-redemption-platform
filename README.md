# accor-redemption-platform
Production-grade AWS EKS platform design for Redemption microservice


The platform is designed to support:

- Zero downtime availability
- 10x traffic spikes
- Automated scaling
- Secure cloud infrastructure
- Observability and reliability

## Architecture

The platform uses:

- AWS EKS
- Terraform
- Kubernetes
- AWS Load Balancer
- RDS Multi-AZ
- Prometheus
- Grafana

## Repository Structure

terraform/
- AWS infrastructure provisioning

kubernetes/
- Application deployment manifests

monitoring/
- Observability configuration

docs/
- Architecture and design documents
