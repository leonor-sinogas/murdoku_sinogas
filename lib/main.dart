import 'package:flutter/material.dart';

const ink = Color(0xFF072D33);
const mauve = Color(0xFF9ABCAB);
const coral = Color(0xFF8F5C64);
const brick = Color(0xFF3A7564);
const brickDark = Color(0xFF33091B);
const paper = Color(0xFFF7F4F1);

void main() => runApp(const MurdokuApp());

class MurdokuApp extends StatelessWidget {
  const MurdokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Murdoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: coral,
          brightness: Brightness.light,
        ),
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
    );
  }
}

class Level {
  const Level({
    required this.number,
    required this.name,
    required this.tagline,
    required this.location,
    required this.victim,
    required this.suspects,
    required this.clues,
    required this.solution,
    required this.blocked,
  });

  final int number;
  final String name;
  final String tagline;
  final String location;
  final String victim;
  final List<String> suspects;
  final List<String> clues;
  final Map<String, int> solution;
  final Set<int> blocked;
}

const levels = <Level>[
  Level(
    number: 1,
    name: 'The All-Day Conference',
    tagline: 'Six hours of presentations. One very bad ending.',
    location: 'Office',
    victim: 'Vincent',
    suspects: [
      'Andre',
      'Bethany',
      'Clyde',
      'Delilah',
      'Eduardo',
      'Felicia',
      'Greg',
      'Helena',
    ],
    clues: [
      'Andre was sitting in a chair.',
      'Bethany was beside a television.',
      'Clyde was in front of a window and was not sitting.',
      'Delilah was not alone: everyone in her division was seated.',
      'Felicia was alone in the break room.',
      'Greg was beside a plant, west of Delilah.',
      'Helena was east of Felicia and west of Delilah.',
      'Eduardo was not sitting and was not in the bathroom.',
    ],
    solution: {
      'Andre': 1,
      'Bethany': 8,
      'Clyde': 4,
      'Delilah': 20,
      'Eduardo': 28,
      'Felicia': 32,
      'Greg': 19,
      'Helena': 18,
    },
    blocked: {0, 5, 7, 12, 14, 21, 25, 26, 30, 33},
  ),
  Level(
    number: 2,
    name: 'Vacation House',
    tagline: 'The bloodstains are not coming out of the Airbnb rug.',
    location: 'Holiday home',
    victim: 'Virgil',
    suspects: ['Arianna', 'Brycen', 'Colleen', 'Dan', 'Evan'],
    clues: [
      'Brycen was sitting in a chair.',
      'Arianna was beside a television.',
      'Colleen was in the bathroom.',
      'Dan was beside a plant and was in a bed.',
      'Evan was beside a bed.',
      'The victim was in the last available cell.',
    ],
    solution: {'Arianna': 31, 'Brycen': 7, 'Colleen': 14, 'Dan': 5, 'Evan': 23},
    blocked: {0, 3, 9, 12, 16, 19, 21, 26, 28, 34},
  ),
  Level(
    number: 3,
    name: 'Study Session',
    tagline: 'Failing the final exam was only the beginning.',
    location: 'Study house',
    victim: 'Vince',
    suspects: ['Aaron', 'Bruno', 'Clara', 'Donna', 'Evelyn'],
    clues: [
      'Aaron was in a bed.',
      'Bruno was the only person in a chair.',
      'Clara was the only person in front of a window.',
      'Donna was in the bathroom.',
      'Evelyn was beside a television.',
      'The victim was in the last available cell.',
    ],
    solution: {'Aaron': 21, 'Bruno': 8, 'Clara': 3, 'Donna': 31, 'Evelyn': 28},
    blocked: {1, 4, 6, 11, 13, 16, 22, 25, 30, 35},
  ),
  Level(
    number: 4,
    name: 'The Laboratory',
    tagline: 'Safety goggles can only protect you so much.',
    location: 'Research lab',
    victim: 'Vaughn',
    suspects: [
      'Ashton',
      'Blaine',
      'Carla',
      'Delilah',
      'Estella',
      'Frank',
      'Galen',
    ],
    clues: [
      'Blaine was in the archive.',
      'Estella was in the first column.',
      'Ashton shared a division with Estella and was sitting in a chair.',
      'Carla was beside a table, north of Blaine.',
      'Galen was beside a bookshelf.',
      'Frank was beside a television.',
      'The victim was alone in the final cell.',
    ],
    solution: {
      'Ashton': 1,
      'Blaine': 17,
      'Carla': 5,
      'Delilah': 30,
      'Estella': 8,
      'Frank': 26,
      'Galen': 20,
    },
    blocked: {0, 4, 6, 11, 15, 18, 22, 24, 29, 33},
  ),
  Level(
    number: 5,
    name: 'Late Night Shift',
    tagline: 'The office lights stayed on. Someone did not.',
    location: 'Office',
    victim: 'Mara',
    suspects: ['Iris', 'Jonah', 'Kendall', 'Luca', 'Mina', 'Nico'],
    clues: [
      'Iris was east of the plant.',
      'Jonah was the only person in a chair.',
      'Kendall was in front of a window.',
      'Luca was beside a television.',
      'Mina was alone in the archive.',
      'Nico was north of Luca.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'Iris': 5,
      'Jonah': 19,
      'Kendall': 2,
      'Luca': 27,
      'Mina': 14,
      'Nico': 9,
    },
    blocked: {0, 3, 8, 12, 16, 22, 24, 30, 31, 35},
  ),
  Level(
    number: 6,
    name: 'Gallery Opening',
    tagline: 'Every painting has a story. This one has a motive.',
    location: 'Gallery',
    victim: 'Rhea',
    suspects: ['Avery', 'Beck', 'Cora', 'Dylan', 'Mae', 'Silas'],
    clues: [
      'Avery was beside a statue.',
      'Beck was seated.',
      'Cora was south of Dylan.',
      'Dylan was in front of a window.',
      'Mae was beside a plant.',
      'Silas was not in the main hall.',
      'The victim was in the last available cell.',
    ],
    solution: {
      'Avery': 6,
      'Beck': 15,
      'Cora': 26,
      'Dylan': 3,
      'Mae': 20,
      'Silas': 31,
    },
    blocked: {1, 4, 9, 11, 17, 21, 24, 28, 32, 34},
  ),
  Level(
    number: 7,
    name: 'Mountain Lodge',
    tagline: 'The storm trapped everyone inside. The killer was already there.',
    location: 'Lodge',
    victim: 'Quinn',
    suspects: ['Ayla', 'Bram', 'Cleo', 'Jasper', 'Nora', 'Otto'],
    clues: [
      'Ayla was beside a fireplace.',
      'Bram was west of the window.',
      'Cleo was in a chair.',
      'Jasper was beside a plant.',
      'Nora was in the room with the television.',
      'Otto was south of Ayla.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'Ayla': 4,
      'Bram': 2,
      'Cleo': 23,
      'Jasper': 18,
      'Nora': 29,
      'Otto': 28,
    },
    blocked: {0, 7, 10, 13, 16, 22, 25, 30, 33, 35},
  ),
  Level(
    number: 8,
    name: 'Hotel Check-In',
    tagline: 'A quiet lobby. A loud secret.',
    location: 'Hotel',
    victim: 'Parker',
    suspects: ['June', 'Kira', 'Miles', 'Reese', 'Sana', 'Toby'],
    clues: [
      'June was beside a television.',
      'Kira was north of the plant.',
      'Miles was not sitting.',
      'Reese was in front of a window.',
      'Sana was beside a bookshelf.',
      'Toby was in the guest room.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'June': 25,
      'Kira': 5,
      'Miles': 12,
      'Reese': 3,
      'Sana': 18,
      'Toby': 31,
    },
    blocked: {1, 4, 8, 11, 15, 19, 22, 27, 30, 34},
  ),
  Level(
    number: 9,
    name: 'Boardroom B-12',
    tagline: 'The quarterly numbers do not add up. Neither do the alibis.',
    location: 'Boardroom',
    victim: 'Rowan',
    suspects: ['Ari', 'Cade', 'Esme', 'Finn', 'Greer', 'Hugo'],
    clues: [
      'Ari was beside a chair.',
      'Cade was in front of a window.',
      'Esme was in the archive.',
      'Finn was beside a television.',
      'Greer was north of Hugo.',
      'Hugo was not alone.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'Ari': 8,
      'Cade': 4,
      'Esme': 13,
      'Finn': 27,
      'Greer': 2,
      'Hugo': 10,
    },
    blocked: {0, 6, 9, 14, 17, 20, 25, 29, 32, 35},
  ),
  Level(
    number: 10,
    name: 'The Last Train',
    tagline: 'One carriage. Six suspects. No way off.',
    location: 'Night train',
    victim: 'Vera',
    suspects: ['Ada', 'Bo', 'Cass', 'Drew', 'Elle', 'Fox'],
    clues: [
      'Ada was in front of a window.',
      'Bo was beside a television.',
      'Cass was sitting.',
      'Drew was east of the plant.',
      'Elle was beside a table.',
      'Fox was not in the first row.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'Ada': 2,
      'Bo': 25,
      'Cass': 14,
      'Drew': 20,
      'Elle': 7,
      'Fox': 31,
    },
    blocked: {0, 4, 9, 11, 16, 18, 23, 27, 30, 34},
  ),
];

// Ordered from the most approachable cases to the most involved deduction.
const levelOrder = <int>[1, 2, 9, 7, 6, 5, 4, 8, 3, 0];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopBar(),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: 520,
                        child: _Hero(
                          onStart: () =>
                              _openLevel(context, levels[levelOrder.first], 1),
                        ),
                      ),
                      SizedBox(
                        width: 430,
                        child: _CaseFileCard(
                          onRules: () => _openRules(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  Text(
                    'Your case files',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          mainAxisExtent: 112,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                    itemCount: levelOrder.length,
                    itemBuilder: (context, index) => _LevelTile(
                      level: levels[levelOrder[index]],
                      caseNumber: index + 1,
                      onTap: () => _openLevel(
                        context,
                        levels[levelOrder[index]],
                        index + 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openLevel(BuildContext context, Level level, int caseNumber) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PuzzleScreen(level: level, caseNumber: caseNumber),
        ),
      );

  void _openRules(BuildContext context) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const RulesScreen()));
}

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('GAME RULES'),
      backgroundColor: Colors.transparent,
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: const _RulesContent(),
      ),
    ),
  );
}

class _RulesContent extends StatelessWidget {
  const _RulesContent();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(28, 12, 28, 36),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How to solve a case',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: ink,
          ),
        ),
        const SizedBox(height: 9),
        const Text(
          'Use the clues to place every suspect in a unique available cell. The murderer is the suspect who shares a room with the victim.',
          style: TextStyle(color: ink, fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 22),
        const _RuleStep(
          number: '1',
          title: 'Read the clues',
          body:
              'All clues are shown together in every case. Look for room names, objects, directions, and whether a person is seated.',
        ),
        const _RuleStep(
          number: '2',
          title: 'Choose a suspect',
          body:
              'Select a suspect chip in the case panel, then choose how you want to mark the board.',
        ),
        const _RuleStep(
          number: '3',
          title: 'Place or note',
          body:
              'Place person makes an official placement. Add notes toggles a small candidate initial in that cell without committing the suspect.',
        ),
        const _RuleStep(
          number: '4',
          title: 'Finish the grid',
          body:
              'Each suspect occupies one row, one column, and one available cell. Thick borders separate the named rooms.',
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFE7EFEB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OBJECT GUIDE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.4,
                  color: brickDark,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Only chairs and beds can be occupied. Every other object cell is blocked and cannot receive an official placement or note.',
                style: TextStyle(color: ink, height: 1.35),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Chair',
                      Icons.weekend,
                      occupiable: true,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Bed',
                      Icons.bed,
                      occupiable: true,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Table',
                      Icons.table_restaurant,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Plant',
                      Icons.local_florist,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Window',
                      Icons.window,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Television',
                      Icons.tv,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Bookshelf',
                      Icons.menu_book,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Statue',
                      Icons.auto_awesome,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Box',
                      Icons.inventory_2,
                      occupiable: false,
                    ),
                  ),
                  _ObjectLegendItem(
                    object: const BoardObject(
                      'Fireplace',
                      Icons.local_fire_department,
                      occupiable: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RuleStep extends StatelessWidget {
  const _RuleStep({
    required this.number,
    required this.title,
    required this.body,
  });
  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: coral, shape: BoxShape.circle),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: brickDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),
              Text(body, style: const TextStyle(color: ink, height: 1.35)),
            ],
          ),
        ),
      ],
    ),
  );
}

void showRulesDialog(BuildContext context) => showDialog(
  context: context,
  builder: (_) => Dialog(
    child: SizedBox(
      width: 560,
      height: 680,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 12, 8),
            child: Row(
              children: [
                Text(
                  'GAME RULES',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: ink,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          const Expanded(child: _RulesContent()),
        ],
      ),
    ),
  ),
);

class _TopBar extends StatelessWidget {
  const _TopBar();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: ink,
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Icon(Icons.search_rounded, color: coral, size: 25),
      ),
      const SizedBox(width: 12),
      Text(
        'MURDOKU',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          color: ink,
        ),
      ),
      const Spacer(),
      Text(
        'CASE FILES  •  10',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF78808D),
        ),
      ),
    ],
  );
}

class _Hero extends StatelessWidget {
  const _Hero({required this.onStart});
  final VoidCallback onStart;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Think like a detective.',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.03,
            color: ink,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Place every suspect on the grid, follow the clues, and discover who shared a room with the victim.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.45,
            color: const Color(0xFF626B79),
          ),
        ),
        const SizedBox(height: 26),
        FilledButton.icon(
          onPressed: onStart,
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Start case 01'),
          style: FilledButton.styleFrom(
            backgroundColor: coral,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _CaseFileCard extends StatelessWidget {
  const _CaseFileCard({required this.onRules});
  final VoidCallback onRules;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: ink,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.folder_open_rounded, color: coral),
            const SizedBox(width: 10),
            Text(
              'FIELD NOTES',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: coral,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Every row and column tells a story.',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A calm, deductive mystery game inspired by classic logic grids.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFFB8BFCA),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 22),
        OutlinedButton.icon(
          onPressed: onRules,
          icon: const Icon(Icons.menu_book_rounded),
          label: const Text('Rules'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: mauve),
          ),
        ),
      ],
    ),
  );
}

class _LevelTile extends StatelessWidget {
  const _LevelTile({
    required this.level,
    required this.caseNumber,
    required this.onTap,
  });
  final Level level;
  final int caseNumber;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E0D8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE7EFEB),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                caseNumber.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: brickDark,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CASE ${caseNumber.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color(0xFF8A919C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded, color: Color(0xFF9AA1AA)),
          ],
        ),
      ),
    ),
  );
}

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({
    super.key,
    required this.level,
    required this.caseNumber,
  });
  final Level level;
  final int caseNumber;
  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class BoardObject {
  const BoardObject(this.name, this.icon, {required this.occupiable});
  final String name;
  final IconData icon;
  final bool occupiable;
}

class RoomLayout {
  const RoomLayout(this.rooms);
  final Map<String, Set<int>> rooms;

  String roomAt(int cell) => rooms.entries
      .firstWhere(
        (entry) => entry.value.contains(cell),
        orElse: () => const MapEntry('', <int>{}),
      )
      .key;

  String labelAt(int cell) {
    for (final entry in rooms.entries) {
      if (entry.value.contains(cell) &&
          cell == entry.value.reduce((a, b) => a < b ? a : b)) {
        return entry.key;
      }
    }
    return '';
  }
}

Set<int> _rect(int top, int bottom, int left, int right) => {
  for (var row = top; row <= bottom; row++)
    for (var col = left; col <= right; col++) row * 6 + col,
};

RoomLayout layoutFor(Level level) {
  switch (level.number) {
    case 1:
      return RoomLayout({
        'Break Room': _rect(0, 2, 0, 2),
        "Director's Office": _rect(0, 2, 3, 5),
        'Bathroom': _rect(3, 5, 0, 2),
        'Meeting Room': _rect(3, 5, 3, 5),
      });
    case 2:
      return RoomLayout({
        'Master Bedroom': _rect(0, 2, 0, 2),
        'Bathroom': _rect(0, 2, 3, 5),
        'Guest Bedroom': _rect(3, 5, 0, 2),
        'Living Room': _rect(3, 5, 3, 5),
      });
    case 3:
      return RoomLayout({
        'Study': _rect(0, 2, 0, 2),
        'Office': _rect(0, 2, 3, 5),
        'Bathroom': _rect(3, 5, 0, 2),
        'Lounge': _rect(3, 5, 3, 5),
      });
    case 4:
      return RoomLayout({
        'Experiments': _rect(0, 2, 0, 2),
        'Archive': _rect(0, 2, 3, 5),
        'Data Analysis': _rect(3, 5, 0, 2),
        'Freezer': _rect(3, 5, 3, 5),
      });
    case 5:
      return RoomLayout({
        'Lobby': _rect(0, 2, 0, 2),
        'Records': _rect(0, 2, 3, 5),
        'Break Room': _rect(3, 5, 0, 2),
        'Boardroom': _rect(3, 5, 3, 5),
      });
    case 6:
      return RoomLayout({
        'Main Gallery': _rect(0, 2, 0, 2),
        'Sculpture Hall': _rect(0, 2, 3, 5),
        "Curator's Office": _rect(3, 5, 0, 2),
        'Storage': _rect(3, 5, 3, 5),
      });
    case 7:
      return RoomLayout({
        'Lounge': _rect(0, 2, 0, 2),
        'Kitchen': _rect(0, 2, 3, 5),
        'Bedrooms': _rect(3, 5, 0, 2),
        'Study': _rect(3, 5, 3, 5),
      });
    case 8:
      return RoomLayout({
        'Lobby': _rect(0, 2, 0, 2),
        'Guest Room': _rect(0, 2, 3, 5),
        'Bathroom': _rect(3, 5, 0, 2),
        'Lounge': _rect(3, 5, 3, 5),
      });
    case 9:
      return RoomLayout({
        'Experiments': _rect(0, 2, 0, 2),
        'Archive': _rect(0, 2, 3, 5),
        'Data Analysis': _rect(3, 5, 0, 2),
        'Freezer': _rect(3, 5, 3, 5),
      });
    default:
      return RoomLayout({
        'Living Room': _rect(0, 2, 0, 2),
        'Office': _rect(0, 2, 3, 5),
        'Bathroom': _rect(3, 5, 0, 2),
        'Main Bedroom': _rect(3, 5, 3, 5),
      });
  }
}

Map<int, BoardObject> objectsFor(Level level) {
  const objects = [
    BoardObject('Chair', Icons.weekend, occupiable: true),
    BoardObject('Bed', Icons.bed, occupiable: true),
    BoardObject('Table', Icons.table_restaurant, occupiable: false),
    BoardObject('Plant', Icons.local_florist, occupiable: false),
    BoardObject('Window', Icons.window, occupiable: false),
    BoardObject('Television', Icons.tv, occupiable: false),
    BoardObject('Bookshelf', Icons.menu_book, occupiable: false),
    BoardObject('Statue', Icons.auto_awesome, occupiable: false),
    BoardObject('Box', Icons.inventory_2, occupiable: false),
    BoardObject('Fireplace', Icons.local_fire_department, occupiable: false),
  ];
  final cells = level.blocked.toList()..sort();
  return {
    for (var index = 0; index < cells.length; index++)
      cells[index]: objects[(index + level.number) % objects.length],
  };
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late final Map<String, int?> placed;
  late final Map<int, Set<String>> notes;
  String? activeSuspect;
  bool notesMode = false;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    placed = {for (final name in widget.level.suspects) name: null};
    notes = {for (var cell = 0; cell < 36; cell++) cell: <String>{}};
  }

  String? occupantAt(int cell) => placed.entries
      .where((entry) => entry.value == cell)
      .map((entry) => entry.key)
      .firstOrNull;

  void tapCell(int cell) {
    final object = objectsFor(widget.level)[cell];
    final blocked =
        widget.level.blocked.contains(cell) && !(object?.occupiable ?? false);
    if (activeSuspect == null || blocked) return;
    setState(() {
      final suspect = activeSuspect!;
      if (notesMode) {
        if (occupantAt(cell) != null) return;
        if (notes[cell]!.contains(suspect)) {
          notes[cell]!.remove(suspect);
        } else {
          notes[cell]!.add(suspect);
        }
      } else {
        final previousCell = placed[suspect];
        if (previousCell != null) notes[previousCell]!.remove(suspect);
        final previousOccupant = occupantAt(cell);
        if (previousOccupant != null && previousOccupant != suspect) {
          placed[previousOccupant] = null;
        }
        placed[suspect] = cell;
        notes[cell]!.clear();
        activeSuspect = null;
      }
      checked = false;
    });
  }

  void check() {
    final complete = placed.values.every((value) => value != null);
    final correct =
        complete &&
        placed.entries.every(
          (entry) => widget.level.solution[entry.key] == entry.value,
        );
    setState(() => checked = true);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          correct
              ? 'Case solved'
              : complete
              ? 'Not quite'
              : 'Keep investigating',
        ),
        content: Text(
          correct
              ? 'Excellent deduction. ${widget.level.victim} was not alone.'
              : complete
              ? 'One or more suspects are in the wrong cell. Re-read the clues and try again.'
              : 'Place every suspect on the grid before checking your solution.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back to case'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('CASE ${widget.caseNumber.toString().padLeft(2, '0')}'),
          IconButton(
            onPressed: () => showRulesDialog(context),
            tooltip: 'Game rules',
            icon: const Icon(Icons.info_outline_rounded, size: 20),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: check, child: const Text('CHECK SOLUTION')),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth > 820;
            final grid = _Grid(
              level: widget.level,
              placed: placed,
              occupantAt: occupantAt,
              activeSuspect: activeSuspect,
              onCellTap: tapCell,
              notes: notes,
              notesMode: notesMode,
            );
            final clues = _Clues(
              level: widget.level,
              placed: placed,
              activeSuspect: activeSuspect,
              onSuspectTap: (name) => setState(() => activeSuspect = name),
              notesMode: notesMode,
              onModeChanged: (value) => setState(() => notesMode = value),
            );
            return Padding(
              padding: const EdgeInsets.all(28),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: grid),
                        const SizedBox(width: 30),
                        Expanded(flex: 4, child: clues),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [grid, const SizedBox(height: 30), clues],
                      ),
                    ),
            );
          },
        ),
      ),
    ),
  );
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.level,
    required this.placed,
    required this.occupantAt,
    required this.activeSuspect,
    required this.onCellTap,
    required this.notes,
    required this.notesMode,
  });
  final Level level;
  final Map<String, int?> placed;
  final String? Function(int) occupantAt;
  final String? activeSuspect;
  final ValueChanged<int> onCellTap;
  final Map<int, Set<String>> notes;
  final bool notesMode;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        level.location.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          color: brickDark,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        level.name,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w900,
          color: ink,
        ),
      ),
      const SizedBox(height: 20),
      AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final layout = layoutFor(level);
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: ink,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                        ),
                    itemCount: 36,
                    itemBuilder: (context, index) {
                      final objects = objectsFor(level);
                      final name = occupantAt(index);
                      final cellNotes = notes[index] ?? <String>{};
                      final room = layout.roomAt(index);
                      final object = objects[index];
                      final blocked =
                          level.blocked.contains(index) &&
                          !(object?.occupiable ?? false);
                      final row = index ~/ 6;
                      final column = index % 6;
                      final eliminatedByPlacement =
                          name == null &&
                          !blocked &&
                          placed.values.any(
                            (cell) =>
                                cell != null &&
                                ((cell ~/ 6) == row || (cell % 6) == column),
                          );
                      final topRoom = layout.roomAt(index - 6);
                      final leftRoom = index % 6 == 0
                          ? ''
                          : layout.roomAt(index - 1);
                      final rightRoom = index % 6 == 5
                          ? ''
                          : layout.roomAt(index + 1);
                      final bottomRoom = layout.roomAt(index + 6);
                      final border = Border(
                        top: BorderSide(
                          color: topRoom == room ? mauve : brickDark,
                          width: topRoom == room ? 1 : 3,
                        ),
                        right: BorderSide(
                          color: rightRoom == room ? mauve : brickDark,
                          width: rightRoom == room ? 1 : 3,
                        ),
                        bottom: BorderSide(
                          color: bottomRoom == room ? mauve : brickDark,
                          width: bottomRoom == room ? 1 : 3,
                        ),
                        left: BorderSide(
                          color: leftRoom == room ? mauve : brickDark,
                          width: leftRoom == room ? 1 : 3,
                        ),
                      );
                      return GestureDetector(
                        onTap: () => onCellTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: blocked
                                ? const Color(0xFFE1E4E5)
                                : name != null
                                ? coral
                                : activeSuspect != null
                                ? const Color(0xFFF1E2E4)
                                : paper,
                            borderRadius: BorderRadius.zero,
                            border: border,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: name != null
                                    ? Text(
                                        name.substring(0, 1),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: ink,
                                          fontSize: 20,
                                        ),
                                      )
                                    : object != null
                                    ? Tooltip(
                                        message:
                                            '${object.name} — ${object.occupiable ? 'can be occupied' : 'cannot be occupied'}',
                                        child: Icon(
                                          object.icon,
                                          color: brickDark.withValues(
                                            alpha: .8,
                                          ),
                                          size: 38,
                                        ),
                                      )
                                    : blocked
                                    ? const Icon(
                                        Icons.close_rounded,
                                        color: mauve,
                                        size: 17,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                              ),
                                          itemCount: 9,
                                          itemBuilder: (context, noteIndex) {
                                            final candidate =
                                                noteIndex <
                                                    level.suspects.length
                                                ? level.suspects[noteIndex]
                                                : null;
                                            return Center(
                                              child: Text(
                                                candidate != null &&
                                                        cellNotes.contains(
                                                          candidate,
                                                        )
                                                    ? candidate
                                                          .substring(0, 1)
                                                          .toUpperCase()
                                                    : '',
                                                style: const TextStyle(
                                                  color: brickDark,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                              if (eliminatedByPlacement)
                                Positioned.fill(
                                  child: IgnorePointer(
                                    child: Center(
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: brickDark.withValues(alpha: .24),
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ...layout.rooms.entries.map((entry) {
                  final firstCell = entry.value.reduce((a, b) => a < b ? a : b);
                  final left = firstCell % 6 < 3
                      ? 6.0
                      : constraints.maxWidth / 2 + 6;
                  final top = firstCell ~/ 6 < 3
                      ? -26.0
                      : constraints.maxHeight / 2 + 5;
                  return Positioned(
                    left: left,
                    top: top,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      color: paper,
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          const Icon(Icons.info_outline_rounded, size: 17, color: mauve),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              activeSuspect == null
                  ? 'Select a suspect, then choose a cell.'
                  : notesMode
                  ? 'Tap cells to add or remove a candidate note for $activeSuspect.'
                  : 'Tap an open cell to place $activeSuspect.',
              style: const TextStyle(color: ink),
            ),
          ),
        ],
      ),
    ],
  );
}

class _ObjectLegendItem extends StatelessWidget {
  const _ObjectLegendItem({required this.object});
  final BoardObject object;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(object.icon, size: 15, color: object.occupiable ? brick : brickDark),
      const SizedBox(width: 3),
      Text(
        object.name,
        style: TextStyle(
          color: object.occupiable ? brick : brickDark,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );
}

class _Clues extends StatelessWidget {
  const _Clues({
    required this.level,
    required this.placed,
    required this.activeSuspect,
    required this.onSuspectTap,
    required this.notesMode,
    required this.onModeChanged,
  });
  final Level level;
  final Map<String, int?> placed;
  final String? activeSuspect;
  final ValueChanged<String> onSuspectTap;
  final bool notesMode;
  final ValueChanged<bool> onModeChanged;
  @override
  Widget build(BuildContext context) {
    final guideObjects = objectsFor(level).values.toSet().toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'THE CASE',
                style: TextStyle(
                  color: coral,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                'Victim: ${level.victim}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                level.tagline,
                style: const TextStyle(color: Color(0xFFE7EFEB), height: 1.35),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'BOARD GUIDE',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: ink,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE7EFEB),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: guideObjects
                    .map((object) => _ObjectLegendItem(object: object))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'SUSPECTS',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: ink,
          ),
        ),
        const SizedBox(height: 11),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: level.suspects
              .map(
                (name) => ChoiceChip(
                  label: Text(name),
                  selected: activeSuspect == name,
                  onSelected: (_) => onSuspectTap(name),
                  avatar: placed[name] != null
                      ? const Icon(Icons.check, size: 15)
                      : null,
                  selectedColor: coral,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: mauve),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        Text(
          'INPUT MODE',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: ink,
          ),
        ),
        const SizedBox(height: 9),
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(
              value: false,
              label: Text('Place person'),
              icon: Icon(Icons.person_add_alt_1_rounded),
            ),
            ButtonSegment(
              value: true,
              label: Text('Add notes'),
              icon: Icon(Icons.edit_note_rounded),
            ),
          ],
          selected: {notesMode},
          onSelectionChanged: (selection) => onModeChanged(selection.first),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) =>
                  states.contains(WidgetState.selected) ? coral : Colors.white,
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected) ? ink : mauve,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Icon(
              Icons.lightbulb_outline_rounded,
              size: 18,
              color: brickDark,
            ),
            const SizedBox(width: 7),
            Text(
              'ALL CLUES',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
                color: brickDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...level.clues.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: entry.key.isEven
                    ? const Color(0xFFE7EFEB)
                    : const Color(0xFFF1E2E4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: entry.key.isEven ? mauve : coral,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
