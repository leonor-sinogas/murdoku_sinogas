# Local development

## Requirements

- Flutter SDK with web, macOS, and iOS targets enabled.
- Dart SDK supplied by Flutter.
- Python is only needed for the simple local web preview server.

## Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
flutter run -d macos
flutter build web --release
python3 -m http.server 8090 --directory build/web
```

## Port 8090

Port `8090` is the agreed local Murdoku preview port. It serves the generated `build/web` directory and is not a production service. If the port is already occupied, inspect the listener before stopping anything; do not kill unrelated processes.

## Testing scope

The current widget tests verify:

- The home screen renders all 10 case files.
- Starting the first case opens the interactive grid and case panel.
- Every case solution uses unique rows and columns, valid grid cells, and complete room coverage.

Add tests for note toggling, official placement replacement, blocked cells, and solution checking as gameplay state grows.
