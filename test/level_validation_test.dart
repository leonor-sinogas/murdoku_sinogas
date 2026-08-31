import 'package:flutter_test/flutter_test.dart';
import 'package:murdoku/main.dart';

void main() {
  test('case ordering includes every level exactly once', () {
    expect(levelOrder.toSet().length, levels.length);
    expect(
      levelOrder,
      containsAll(List<int>.generate(levels.length, (i) => i)),
    );
  });

  test('visible puzzle one has one uniquely fixed suspect solution', () {
    final level = levels.firstWhere((level) => level.number == 2);
    final fixedPositions = positionCluesFor(level);
    expect(fixedPositions, isEmpty);
    for (final suspect in level.suspects) {
      final clues = level.clues.where(
        (clue) => clue.toLowerCase().startsWith(suspect.toLowerCase()),
      );
      final coordinateReferences = clues
          .map((clue) => RegExp(r'\b(row|column)\b').allMatches(clue).length)
          .fold<int>(0, (total, count) => total + count);
      expect(
        coordinateReferences,
        suspect == 'Colleen' ? 1 : 0,
        reason: '$suspect has unnecessary direct coordinate information',
      );
    }
    expect(level.fixedObjects, containsPair(34, 'Television'));
    expect(level.fixedObjects, containsPair(19, 'Bed'));
    expect(level.fixedObjects, containsPair(25, 'Bed'));

    final layout = layoutFor(level);
    final objects = objectsFor(level);
    final available = <int>[
      for (var cell = 0; cell < level.gridSize * level.gridSize; cell++)
        if (!level.blocked.contains(cell) || objects[cell]?.occupiable == true)
          cell,
    ];
    final assignments = <String, int>{};
    final usedRows = <int>{};
    final usedColumns = <int>{};
    var solutionCount = 0;

    bool adjacentToObject(int cell, String objectName) => objects.entries.any(
      (entry) =>
          entry.value.name == objectName &&
          layout.roomAt(entry.key) == layout.roomAt(cell) &&
          _testCellsAreAdjacent(cell, entry.key, level.gridSize),
    );

    void search(int index) {
      if (index == level.suspects.length) {
        solutionCount++;
        return;
      }
      final suspect = level.suspects[index];
      for (final cell in available) {
        final row = cell ~/ level.gridSize;
        final column = cell % level.gridSize;
        if (usedRows.contains(row) || usedColumns.contains(column)) continue;
        final object = objects[cell];
        final valid = switch (suspect) {
          'Arianna' => adjacentToObject(cell, 'Television'),
          'Brycen' => object?.name == 'Chair',
          'Colleen' => layout.roomAt(cell) == 'Bathroom' && row == 2,
          'Dan' => object?.name == 'Bed' && adjacentToObject(cell, 'Plant'),
          'Evan' => adjacentToObject(cell, 'Bed'),
          _ => true,
        };
        if (!valid) continue;
        assignments[suspect] = cell;
        usedRows.add(row);
        usedColumns.add(column);
        search(index + 1);
        usedRows.remove(row);
        usedColumns.remove(column);
        assignments.remove(suspect);
      }
    }

    search(0);
    expect(solutionCount, 1);
    expect(assignments, isEmpty);
  });

  test('object-led cases have one suspect placement', () {
    for (final level in levels.where((level) => level.number >= 11)) {
      final layout = layoutFor(level);
      final objects = objectsFor(level);
      final available = <int>[
        for (var cell = 0; cell < level.gridSize * level.gridSize; cell++)
          if (!level.blocked.contains(cell) ||
              objects[cell]?.occupiable == true)
            cell,
      ];
      final assignments = <String, int>{};
      final usedRows = <int>{};
      final usedColumns = <int>{};
      var solutionCount = 0;

      bool besideObject(int cell, String name) => objects.entries.any(
        (entry) =>
            entry.value.name == name &&
            layout.roomAt(entry.key) == layout.roomAt(cell) &&
            _testCellsAreAdjacent(cell, entry.key, level.gridSize),
      );

      bool eastOfObject(int cell, String name) => objects.entries.any(
        (entry) =>
            entry.value.name == name &&
            layout.roomAt(entry.key) == layout.roomAt(cell) &&
            cell % level.gridSize > entry.key % level.gridSize,
      );

      final clueObjects = <String>[
        for (final clue in level.clues.take(5)) objectNamesInClue(clue).single,
      ];

      void search(int index) {
        if (index == level.suspects.length) {
          solutionCount++;
          return;
        }
        final suspect = level.suspects[index];
        for (final cell in available) {
          final row = cell ~/ level.gridSize;
          final column = cell % level.gridSize;
          if (usedRows.contains(row) || usedColumns.contains(column)) continue;
          final valid = switch (index) {
            0 => objects[cell]?.name == 'Chair',
            1 || 2 || 3 => besideObject(cell, clueObjects[index]),
            4 => row == 4 && eastOfObject(cell, clueObjects[index]),
            _ => false,
          };
          if (!valid) continue;
          assignments[suspect] = cell;
          usedRows.add(row);
          usedColumns.add(column);
          search(index + 1);
          usedRows.remove(row);
          usedColumns.remove(column);
          assignments.remove(suspect);
        }
      }

      search(0);
      expect(
        solutionCount,
        1,
        reason: '${level.name} should be uniquely solvable',
      );
    }
  });

  test('test adjacency helper sanity check', () {
    expect(_testCellsAreAdjacent(19, 20, 6), isTrue);
    expect(_testCellsAreAdjacent(19, 26, 6), isFalse);
  });

  test('every case solution satisfies the board rules', () {
    for (final level in levels) {
      final layout = layoutFor(level);
      final objects = objectsFor(level);
      final answer = solutionFor(level);
      final solutionCells = level.solution.values.toList();
      final rows = solutionCells.map((cell) => cell ~/ level.gridSize).toSet();
      final columns = solutionCells
          .map((cell) => cell % level.gridSize)
          .toSet();
      final boardCellCount = level.gridSize * level.gridSize;

      for (final clue in level.clues) {
        final person = cluePersonName(clue, level);
        if (person == null || objectNamesInClue(clue).isEmpty) continue;
        final personCell = answer[person];
        expect(personCell, isNotNull, reason: '${level.name}: $clue');
        final personRoom = layout.roomAt(personCell!);
        for (final objectName in objectNamesInClue(clue)) {
          expect(
            objects.entries.any(
              (entry) =>
                  entry.value.name == objectName &&
                  layout.roomAt(entry.key) == personRoom,
            ),
            isTrue,
            reason: '${level.name}: missing $objectName for $clue',
          );
        }
      }

      for (final entry in objects.entries) {
        final roomName = layout.roomAt(entry.key).toLowerCase();
        if (entry.value.name == 'Bed') {
          expect(
            roomName.contains('bedroom'),
            isTrue,
            reason: '${level.name}: bed outside a bedroom',
          );
        }
        if (entry.value.name == 'Window') {
          final row = entry.key ~/ level.gridSize;
          final column = entry.key % level.gridSize;
          expect(
            row == 0 ||
                column == 0 ||
                row == level.gridSize - 1 ||
                column == level.gridSize - 1,
            isTrue,
            reason: '${level.name}: window is not next to an outside wall',
          );
        }
      }

      expect(
        level.solution.keys.length,
        level.suspects.length,
        reason: level.name,
      );
      expect(answer.keys, contains(level.victim), reason: level.name);
      final victimRoom = layout.roomAt(answer[level.victim]!);
      expect(
        level.suspects
            .where((suspect) => layout.roomAt(answer[suspect]!) == victimRoom)
            .length,
        1,
        reason: '${level.name}: victim room must contain exactly one suspect',
      );
      expect(
        objectCluesMatch(level, answer),
        isTrue,
        reason: '${level.name}: invalid seated object relationship',
      );

      final directionalClue = RegExp(
        r'^(\w+) was (east|west|north|south) of (\w+)\.',
        caseSensitive: false,
      );
      for (final clue in level.clues) {
        final match = directionalClue.firstMatch(clue);
        if (match == null) continue;
        final first = answer[match.group(1)!];
        final second = answer[match.group(3)!];
        expect(first, isNotNull, reason: '${level.name}: $clue');
        expect(second, isNotNull, reason: '${level.name}: $clue');
        final firstRow = first! ~/ level.gridSize;
        final firstColumn = first % level.gridSize;
        final secondRow = second! ~/ level.gridSize;
        final secondColumn = second % level.gridSize;
        final direction = match.group(2)!.toLowerCase();
        expect(
          switch (direction) {
            'east' => firstColumn > secondColumn,
            'west' => firstColumn < secondColumn,
            'north' => firstRow < secondRow,
            _ => firstRow > secondRow,
          },
          isTrue,
          reason: '${level.name}: $clue',
        );
      }
      expect(
        level.suspects.every(level.solution.containsKey),
        isTrue,
        reason: level.name,
      );
      expect(
        solutionCells.toSet().length,
        solutionCells.length,
        reason: '${level.name}: duplicate cells',
      );
      expect(
        rows.length,
        solutionCells.length,
        reason: '${level.name}: duplicate rows',
      );
      expect(
        columns.length,
        solutionCells.length,
        reason: '${level.name}: duplicate columns',
      );
      expect(
        solutionCells.every((cell) => cell >= 0 && cell < boardCellCount),
        isTrue,
        reason: '${level.name}: out-of-grid cell',
      );
      expect(
        solutionCells.every((cell) {
          final object = objects[cell];
          return (!level.blocked.contains(cell) &&
                  object?.occupiable != false) ||
              object?.occupiable == true;
        }),
        isTrue,
        reason: '${level.name}: solution uses a blocked cell',
      );

      final allRoomCells = layout.rooms.values.expand((cells) => cells).toSet();
      expect(
        layout.rooms.values.every((cells) => cells.isNotEmpty),
        isTrue,
        reason: '${level.name}: empty room',
      );
      expect(
        allRoomCells.length,
        boardCellCount,
        reason: '${level.name}: rooms do not cover the board',
      );
    }
  });
}

bool _testCellsAreAdjacent(int first, int second, int size) {
  final firstRow = first ~/ size;
  final firstColumn = first % size;
  final secondRow = second ~/ size;
  final secondColumn = second % size;
  return (firstRow - secondRow).abs() + (firstColumn - secondColumn).abs() == 1;
}
