# Gameplay and puzzle model

## Goal

Each case contains a grid divided into rooms or areas, a victim, and a group of suspects. A person occupies one available cell. The player uses the clues to determine every suspect’s location. The murderer is the suspect who shares a division with the victim.

The home screen orders the current cases from easier to more involved and assigns visible case numbers sequentially: Vacation House, Study Session, The Last Train, Hotel Check-In, Mountain Lodge, Gallery Opening, Late Night Shift, Boardroom B-12, The Laboratory, and The All-Day Conference.

The **Rules** button on the home screen opens a full-screen rules page. While a case is open, the information icon beside the case title opens the same rules in a review dialog without leaving the puzzle.

## Player interaction

1. Choose a case from the home page.
2. Select a suspect chip.
3. Choose an input mode:
   - **Place person**: tap an open cell to make the suspect’s official placement. A cell can contain only one official occupant.
   - **Add notes**: tap a cell to toggle that suspect as a candidate.
4. Candidate notes use fixed Sudoku-style slots. The first suspect is always in slot 1, the second in slot 2, and so on. Empty slots remain empty; notes never shift around.
5. Tap **Check solution** after placing every suspect.

## Board objects and rooms

Every case board is divided into four named rooms. Thick borders mark room boundaries, and each room name is shown on its board. The board guide explains object behavior:

- Chairs, beds, and windows are occupiable cells. Windows only appear next to
  an outside wall of the board.
- Tables, plants, televisions, bookshelves, statues, boxes, and fireplaces are blocked cells.
- Hovering an object on web shows whether it can be occupied.

Object cells are not valid official placements or candidate-note cells. Room and object layouts are currently local case data and will become server-delivered level metadata in the backend phase.

Object relationships are room-scoped: a clue such as “beside a plant” or “in front of a window” only applies when the person and the referenced object are inside the same named room. A nearby object across a thick room boundary does not satisfy the clue.

Directional clues use the board compass: east means a larger column number,
west means a smaller column number, north means a smaller row number, and
south means a larger row number. These comparisons are based on the board
coordinates, while “beside” and “in front of” remain local neighboring/object
relationships within the same room.

If a clue says a character is beside an object and seated or lying in a chair
or bed, the occupied chair/bed and referenced object must be adjacent cells in
the same room. A character cannot satisfy both parts when those objects are
separated or across a room boundary.

## Data model in the MVP

Each level in `lib/main.dart` has:

- `number`, `name`, `tagline`, and `location` for presentation.
- `victim` and an ordered `suspects` list.
- `clues`, shown together in the case panel.
- `solution`, mapping each suspect to a grid cell index.
- `blocked`, the cells that cannot be occupied.

The current solution checker is intentionally local and deterministic. It validates whether every suspect has been placed in the supplied solution cell; it does not yet derive solutions from a general-purpose constraint engine.

## Planned gameplay improvements

- Persist progress per signed-in user through the API.
- Add undo/redo and clear-cell actions.
- Model room/division boundaries and object adjacency as first-class puzzle data.
- Validate clue consistency server-side when levels are authored.
- Store completion time, attempts, and optional hints.
