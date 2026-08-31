# Puzzle authoring reference

This document records the conventions used by the thirty local MVP cases.

## Coordinates

Cells use zero-based row-major indexes:

```text
cell = row * gridSize + column
```

Rows increase from north to south. Columns increase from west to east. Therefore:

- east: larger column number;
- west: smaller column number;
- north: smaller row number;
- south: larger row number.

The directional validator in `test/level_validation_test.dart` protects these
conventions from accidental clue or solution changes.

## Character placement

`Level.solution` contains the suspect placements. The victim is added by
`solutionFor`, which selects a remaining valid cell. The UI creates a placement
slot for every suspect plus the victim. A case is complete only when all of
those characters have official placements.

The murderer is not a separately placed entity. After the board is complete,
the victim must share a room with exactly one suspect; that suspect is the
murderer. The player selects an accusation, and the checker reports whether it
is correct.

## Rooms and objects

`layoutFor` divides every board into four named rooms. `objectsFor` maps blocked
cells to object types and reconciles those placements with the objects named by
each clue. Occupiable objects are chairs, beds, and windows;
non-occupiable objects include tables, plants, televisions, bookshelves,
statues, boxes, and fireplaces.

Windows must be on the outside perimeter. If a clue combines a seated/lying
character with a beside-object relationship, the seat and referenced object
must be adjacent and in the same room. Room boundaries are meaningful: a
nearby object across a thick border does not satisfy the clue.

## UI behavior

- All clues are shown together and ordered by character name.
- Place mode creates or removes an official character placement.
- Notes mode toggles uppercase character initials in fixed Sudoku-style slots.
- In notes mode, chairs, beds, and windows remain visible beneath the initials.
- Official placement removes that character’s notes everywhere.
- Row and column elimination X marks are translucent overlays, so they do not
  hide object icons.
- The object guide is generated from the objects that actually appear on the
  current board.

## Adding a case

The current second set contains twenty additional six-by-six cases numbered
11 through 30. They use four named three-by-three rooms, five suspects, and a
victim derived from the final valid cell. Their room names and themes vary.
Their clues are object-led: four unique object relationships and one
single-coordinate/object-direction clue. Do not give a character both a row
and a column, and do not replace these cases with a repeated people-to-people
direction chain.

When adding or changing a case:

1. Add the level data in `lib/main.dart`.
2. Keep suspect names and clues alphabetically ordered.
3. Add a room layout covering every cell.
4. Ensure every object relationship is in the referenced character’s room.
5. Ensure every object named by a clue is present; `beside` and `in front of`
   relationships must use adjacent cells in the same room.
6. Ensure the victim’s room contains exactly one suspect.
7. Keep windows on perimeter cells and verify chair/bed adjacency rules.
8. Add or update the solution and blocked cells.
9. Run `flutter analyze`, `flutter test`, and `flutter build web --release`.

For object-led cases, add an exhaustive uniqueness test when the clue pattern
or object anchors change. The existing validation suite proves the current
cases 11–30 each have exactly one suspect placement.

Do not add credentials, deployment configuration containing secrets, or
production infrastructure files to the local MVP.
