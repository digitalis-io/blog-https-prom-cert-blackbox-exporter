# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Blog post: Monitoring HTTPS Certificate Expiry with Prometheus and Blackbox Exporter
- Docker Compose stack with NGINX (HTTPS), Blackbox Exporter, Prometheus, and Alertmanager
- `generate-certs.sh`: script to create a local CA and server certificate for testing
- `blackbox.yml`: Blackbox Exporter configuration for TLS probing
- `prometheus.yml`: Prometheus scrape and alerting configuration
- `alert-rules.yml`: Alertmanager alert rules for certificate expiry
- `nginx.conf`: NGINX HTTPS configuration
- `index.html`: minimal HTTPS test page
- `.gitignore`: excludes generated certificates and local artefacts
