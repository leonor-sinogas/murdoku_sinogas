# Murdoku

Murdoku is a Flutter logic-murder puzzle game. Players place suspects into a grid using written clues, then identify the murderer as the person sharing a division with the victim.

This repository currently contains the local-first Flutter MVP:

- Home page with 10 case files.
- English puzzle content based on the supplied logic-grid references.
- Responsive Flutter UI for web, macOS, and iOS targets.
- Official suspect placement mode.
- Sudoku-style candidate-note mode with fixed 3×3 note slots and uppercase initials.
- All clues visible together in the case panel.
- Local solution checking.
- Search/magnifying-glass browser favicon using the Murdoku palette.

The requested FastAPI backend, authentication, PostgreSQL service, AWS infrastructure, persistent accounts, and production deployment are documented as the next architecture phase but are not implemented or deployed yet.

## Run locally

From the repository root:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d macos
flutter run -d chrome
```

To serve the release web bundle locally on the project’s preview port:

```bash
flutter build web --release
python3 -m http.server 8090 --directory build/web
```

Open <http://localhost:8090>.

The app is intentionally local-only at this stage. No command in the normal local workflow deploys to AWS.

## Project map

```text
lib/main.dart          Flutter app, level data, gameplay UI, placement and notes state
test/widget_test.dart  Home and case-opening smoke tests
web/index.html         Web metadata and favicon reference
web/favicon.svg        Murdoku magnifying-glass favicon
docs/                  Product, gameplay, and target architecture documentation
```

## Quality checks

The expected pre-commit checks are:

```bash
flutter analyze
flutter test
flutter build web --release
```

## Target production architecture

The intended production topology is recorded in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md). In summary:

- Flutter client for macOS, iOS, and web.
- Python/FastAPI API in containers on an AWS EC2 `t4g.micro`.
- Containerized PostgreSQL with persistent storage and backups.
- Caddy in front of the API with trusted HTTPS.
- Private S3 bucket `world-connect` behind CloudFront for the web build.
- Namecheap DNS for `world-connect.alicenbob.com` and `world-connect-api.alicenbob.com`.
- AWS CLI/deployment profile `alicenbob-sso`.
- Least-privilege IAM, SSM instead of SSH, no unnecessary public ports, and cache-controlled frontend releases.
