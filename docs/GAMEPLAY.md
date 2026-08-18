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

- Chairs, beds, and windows are occupiable cells.
- Tables, plants, televisions, bookshelves, statues, boxes, and fireplaces are blocked cells.
- Hovering an object on web shows whether it can be occupied.

Object cells are not valid official placements or candidate-note cells. Room and object layouts are currently local case data and will become server-delivered level metadata in the backend phase.

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
