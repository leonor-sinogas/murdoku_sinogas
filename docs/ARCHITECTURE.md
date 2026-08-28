# Murdoku target architecture

This document describes the requested production architecture. It is a target design, not a claim that the infrastructure is already deployed.

## Components

```text
Flutter client (macOS / iOS / web)
       |
       | HTTPS: murdoku-api.alicenbob.com (future backend)
       v
Caddy + FastAPI containers on EC2 t4g.micro
       |
       v
Containerized PostgreSQL with persistent volume and backups

Flutter web build -> private S3 bucket murdoku -> CloudFront
Namecheap DNS -> CloudFront and API endpoints
```

## Frontend

- Flutter is the shared client technology.
- Web artifacts are built with `flutter build web --release`.
- The S3 bucket `murdoku` remains private and is readable only by its dedicated
  CloudFront distribution through Origin Access Control.
- CloudFront is the only public delivery path for `murdoku.alicenbob.com`.
- Use immutable or versioned asset names where possible, with short/no-cache behavior for the HTML shell and long-lived caching for hashed assets.
- ACM wildcard certificate: `*.alicenbob.com`, provisioned in the AWS region required by CloudFront.

## Backend

- Python with FastAPI.
- Container images should be pinned to reproducible base-image versions and scanned before release.
- Caddy terminates HTTPS for `world-connect-api.alicenbob.com` and reverse-proxies to FastAPI over the private Docker network.
- Only TCP 80/443 should be exposed publicly as required for certificate issuance and HTTPS redirects. Administration should use AWS Systems Manager Session Manager instead of SSH.
- API responsibilities should include authentication, level delivery, progress persistence, completion records, and administrative level management.

## Database and persistence

- PostgreSQL runs in a container on the EC2 host.
- Database data must live on a persistent encrypted EBS volume, never only in a container layer.
- Backups should be automated, encrypted, retained, and periodically restored in an isolated test environment.
- Uploads or future user assets should use persistent storage and should not be stored inside ephemeral containers.

## Authentication and security

- Use password authentication with strong password hashing such as Argon2id or bcrypt; never store plaintext passwords.
- Use short-lived access tokens and revocable refresh sessions, or an equivalent secure session design.
- Apply rate limits to login and password-reset routes.
- Validate and authorize every user-owned progress request server-side.
- Keep secrets in AWS-managed secret storage or encrypted parameter storage; do not commit credentials or `.env` files.
- Apply least-privilege IAM to deployment and runtime roles.
- Restrict security groups to the ports and sources actually required.
- Add structured audit logs, health checks, dependency updates, and alerting.

## DNS and TLS

Namecheap records point:

- `murdoku.alicenbob.com` to `dawjoi11ujhz9.cloudfront.net`.
- `murdoku-api.alicenbob.com` to the future API entry point.

CloudFront reuses the issued `*.alicenbob.com` ACM certificate and redirects HTTP
to HTTPS. The distribution is protected by a dedicated WAF ACL and writes
access logs to a private dedicated log bucket. Caddy will use a trusted
certificate for the future API hostname; all client API calls must use HTTPS.

## Deployment profile and operational workflow

The requested AWS profile is `alicenbob-sso`. Deployment automation should:

1. Run isolated tests and static checks.
2. Build and scan backend images.
3. Build the Flutter web release.
4. Upload assets to the private S3 bucket with cache headers.
5. Invalidate only the CloudFront HTML entry points when needed.
6. Deploy API containers through a controlled, reversible process.
7. Run health checks and smoke tests.
8. Record the release version and migration status.

The frontend is deployed. No backend deployment should be run until the backend,
database migrations, secrets, backups, and rollback procedure are implemented
and reviewed.
