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
