# Gameplay and puzzle model

## Goal

Each case contains a grid divided into rooms or areas, a victim, and a group of suspects. Every character, including the victim, occupies one available cell. The player uses the clues to determine every character’s location. The victim must share a room with exactly one suspect; that suspect is the murderer.

The home screen orders the current cases from easier to more involved and assigns visible case numbers sequentially. It now contains the original ten cases plus twenty new cases: The Museum After Dark, The Sleeper Car, The County Courthouse, The Garden Party, The Night Clinic, The Recording Studio, The Harbor Ferry, The Boarding School, The Grand Theater, The Research Annex, The Lakeside Cottage, The Executive Retreat, The Bakery Before Dawn, The Penthouse Party, The Natural History Wing, The Harvest Supper, The Casino Floor, The Independent Bookshop, The Beach House Weekend, and The Hotel Convention.

The **Rules** button on the home screen opens a full-screen rules page. While a case is open, the information icon in the bottom-left help footer opens the same rules in a review dialog without leaving the puzzle.

## Player interaction

1. Choose a case from the home page.
2. Select a character chip. The victim is included in the character list and must also be placed.
3. Choose an input mode:
   - **Place person**: tap an open cell to make the suspect’s official placement. A cell can contain only one official occupant.
   - **Add notes**: tap a cell to toggle that suspect as a candidate.
4. Candidate notes use fixed Sudoku-style slots. The first suspect is always in slot 1, the second in slot 2, and so on. Empty slots remain empty; notes never shift around.
5. Use **Mark X** to add personal elimination marks. These are separate from automatic row/column eliminations caused by official placements.
6. Use **Undo** to remove the last official placement and restore the notes and personal marks that existed before it.
7. Use **Clear puzzle** beside Undo to restart the current case after confirmation.
8. Select the suspect you think is the murderer and tap **Submit accusation**. A correct answer shows a celebration; an incorrect accusation tells you to revisit the clues.

The accusation is checked independently from the exact character placements. If
the murderer is identified while some other characters are misplaced, the game
still celebrates the deduction and explains that it was found in a peculiar way.

## Board objects and rooms

Every case board is divided into four named rooms. Thick borders mark room boundaries. Room names are displayed outside the grid, aligned above the upper rooms and below the lower rooms; no room name is drawn inside a puzzle cell. The board guide explains object behavior:

- Chairs, beds, and windows are occupiable cells. Their cells can receive an
  official character placement or candidate notes. Windows only appear next to
  an outside wall of the board.
- Tables, plants, televisions, bookshelves, statues, boxes, and fireplaces are blocked cells and cannot receive a character or note.
- Hovering an object on web shows whether it can be occupied.

Room and object layouts are currently local case data and will become server-delivered level metadata in the backend phase.

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

Puzzle 1 intentionally omits redundant coordinates. Arianna's television clue
already leaves only one viable adjacent cell, so an additional row clue would
add no deduction and is not shown.

## Data model in the MVP

Each level in `lib/main.dart` has:

- `number`, `name`, `tagline`, and `location` for presentation.
- `victim` and an ordered `suspects` list.
- `clues`, shown together in the case panel.
- `solution`, mapping each suspect to a grid cell index. `solutionFor` derives the victim’s required cell from the remaining valid board cells.
- `blocked`, the cells that cannot be occupied.

The current solution checker is intentionally local and deterministic. It validates every character, compass direction, window boundary, and seated/lying object relationship against the supplied case data; it does not yet derive solutions from a general-purpose constraint engine.

When a character is placed officially, all notes for that character are removed
from the board. Removing an official placement does not remove other characters’
notes.

## Planned gameplay improvements

- Persist progress per signed-in user through the API.
- Add redo and clear-cell actions.
- Model room/division boundaries and object adjacency as first-class puzzle data.
- Validate clue consistency server-side when levels are authored.
- Store completion time, attempts, and optional hints.
