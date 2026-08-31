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

- The home screen renders all 30 case files.
- Starting the first case opens the interactive grid and case panel.
- Every case solution uses unique rows and columns, valid grid cells, and complete room coverage.
- Windows are on outside-wall cells.
- East/west/north/south clues agree with the board compass.
- Combined chair/bed and beside-object clues use adjacent cells in the same room.
- Cases 11–30 have exactly one suspect placement under their displayed
  object-led clue sets.

The permanent tests live in `test/level_validation_test.dart` and
`test/widget_test.dart`. Add tests for note toggling, official placement
replacement, blocked cells, victim placement, murderer checking, and solution
checking as gameplay state grows.
