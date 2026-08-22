# Murdoku

Murdoku is a Flutter logic-murder puzzle game. Players place suspects into a grid using written clues, then identify the murderer as the person sharing a division with the victim.

This repository currently contains the local-first Flutter MVP:

- Home page with 30 case files, including 20 new English cases based on the supplied reference puzzles.
- English puzzle content based on the supplied logic-grid references.
- Responsive Flutter UI for web, macOS, and iOS targets.
- Official suspect placement mode.
- Victim placement as a required character, followed by murderer selection and answer checking.
- Sudoku-style candidate-note mode with fixed 3×3 note slots and uppercase initials.
- All clues visible together in the case panel.
- Named room divisions with thick room borders and room labels on each board.
- Object cells for chairs, beds, tables, plants, windows, televisions, bookshelves, statues, boxes, and fireplaces, with an occupancy legend.
- Local solution checking, including the murderer reveal after an incorrect accusation.
- Rules available from the home screen and from the info button in the bottom-left footer of an open case.
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
test/level_validation_test.dart  Board, compass, window, and object-clue regression tests
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

The release build is written to `build/web`; it is not deployed automatically.

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
