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
    this.gridSize = 6,
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
  final int gridSize;
}

const levels = <Level>[
  Level(
    number: 1,
    gridSize: 9,
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
      'Andre': 0,
      'Bethany': 10,
      'Clyde': 20,
      'Delilah': 30,
      'Eduardo': 40,
      'Felicia': 50,
      'Greg': 60,
      'Helena': 70,
    },
    blocked: {4, 13, 22, 31, 39, 49, 58, 67, 76, 79},
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
    solution: {'Arianna': 5, 'Brycen': 6, 'Colleen': 15, 'Dan': 19, 'Evan': 28},
    blocked: {0, 3, 9, 12, 16, 19, 25, 26, 28, 34},
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
    solution: {'Aaron': 0, 'Bruno': 7, 'Clara': 14, 'Donna': 21, 'Evelyn': 28},
    blocked: {1, 4, 6, 11, 13, 16, 22, 25, 30, 35},
  ),
  Level(
    number: 4,
    gridSize: 7,
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
      'Blaine': 7,
      'Carla': 16,
      'Delilah': 24,
      'Estella': 32,
      'Frank': 40,
      'Galen': 48,
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
      'Nico was south of Luca.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'Iris': 1,
      'Jonah': 6,
      'Kendall': 14,
      'Luca': 21,
      'Mina': 29,
      'Nico': 34,
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
      'Cora was north of Dylan.',
      'Dylan was in front of a window.',
      'Mae was beside a plant.',
      'Silas was not in the main hall.',
      'The victim was in the last available cell.',
    ],
    solution: {
      'Avery': 0,
      'Beck': 7,
      'Cora': 14,
      'Dylan': 22,
      'Mae': 27,
      'Silas': 35,
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
      'Ayla': 1,
      'Bram': 6,
      'Cleo': 14,
      'Jasper': 21,
      'Nora': 29,
      'Otto': 34,
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
      'June': 0,
      'Kira': 7,
      'Miles': 14,
      'Reese': 21,
      'Sana': 28,
      'Toby': 35,
    },
    blocked: {1, 4, 8, 11, 15, 19, 21, 22, 27, 30, 34},
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
      'Ari': 1,
      'Cade': 6,
      'Esme': 15,
      'Finn': 23,
      'Greer': 26,
      'Hugo': 34,
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
      'Ada': 0,
      'Bo': 7,
      'Cass': 14,
      'Drew': 21,
      'Elle': 28,
      'Fox': 35,
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
              'All clues are shown together in every case. Look for room names, objects, directions, and whether a person is seated. Object relationships only count when the person and object are in the same room.',
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
                'Chairs, beds, and windows can be occupied. Every other object cell is blocked and cannot receive an official placement or note.',
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
                      occupiable: true,
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

Set<int> _rect(int top, int bottom, int left, int right, [int size = 6]) => {
  for (var row = top; row <= bottom; row++)
    for (var col = left; col <= right; col++) row * size + col,
};

RoomLayout layoutFor(Level level) {
  switch (level.number) {
    case 1:
      return RoomLayout({
        'Break Room': _rect(0, 3, 0, 3, 9),
        "Director's Office": _rect(0, 3, 4, 8, 9),
        'Bathroom': _rect(4, 8, 0, 3, 9),
        'Meeting Room': _rect(4, 8, 4, 8, 9),
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
        'Main Bedroom': _rect(0, 2, 0, 2),
        'Office': _rect(0, 2, 3, 5),
        'Bathroom': _rect(3, 5, 0, 2),
        'Living Room': _rect(3, 5, 3, 5),
      });
    case 4:
      return RoomLayout({
        'Experiments': _rect(0, 2, 0, 2, 7),
        'Archive': _rect(0, 2, 3, 6, 7),
        'Data Analysis': _rect(3, 6, 0, 2, 7),
        'Freezer': _rect(3, 6, 3, 6, 7),
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
        'Guest Bedroom': _rect(0, 2, 3, 5),
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

Map<String, int> solutionFor(Level level) {
  final solution = Map<String, int>.from(level.solution);
  final usedRows = solution.values
      .map((cell) => cell ~/ level.gridSize)
      .toSet();
  final usedColumns = solution.values
      .map((cell) => cell % level.gridSize)
      .toSet();
  final layout = layoutFor(level);
  final objects = objectsFor(level);
  final available = <int>[];
  for (var cell = 0; cell < level.gridSize * level.gridSize; cell++) {
    final object = objects[cell];
    if (!level.blocked.contains(cell) || object?.occupiable == true) {
      available.add(cell);
    }
  }
  final suspectRooms = solution.values
      .map(layout.roomAt)
      .where((room) => room.isNotEmpty)
      .toSet();
  final victimCell = available.reversed.firstWhere(
    (cell) =>
        suspectRooms.contains(layout.roomAt(cell)) &&
        !usedRows.contains(cell ~/ level.gridSize) &&
        !usedColumns.contains(cell % level.gridSize),
    orElse: () => available.reversed.firstWhere(
      (cell) => suspectRooms.contains(layout.roomAt(cell)),
      orElse: () => available.last,
    ),
  );
  solution[level.victim] = victimCell;
  return solution;
}

String? murdererFor(Level level, Map<String, int> solution) {
  final victimRoom = layoutFor(level).roomAt(solution[level.victim]!);
  for (final suspect in level.suspects) {
    if (layoutFor(level).roomAt(solution[suspect]!) == victimRoom) {
      return suspect;
    }
  }
  return null;
}

Map<int, BoardObject> objectsFor(Level level) {
  const objects = [
    BoardObject('Chair', Icons.weekend, occupiable: true),
    BoardObject('Bed', Icons.bed, occupiable: true),
    BoardObject('Table', Icons.table_restaurant, occupiable: false),
    BoardObject('Plant', Icons.local_florist, occupiable: false),
    BoardObject('Window', Icons.window, occupiable: true),
    BoardObject('Television', Icons.tv, occupiable: false),
    BoardObject('Bookshelf', Icons.menu_book, occupiable: false),
    BoardObject('Statue', Icons.auto_awesome, occupiable: false),
    BoardObject('Box', Icons.inventory_2, occupiable: false),
    BoardObject('Fireplace', Icons.local_fire_department, occupiable: false),
  ];
  final cells = level.blocked.toList()..sort();
  final size = level.gridSize;
  final layout = layoutFor(level);
  bool isOutsideWall(int cell) {
    final row = cell ~/ size;
    final column = cell % size;
    return row == 0 || column == 0 || row == size - 1 || column == size - 1;
  }

  bool roomAllowsObject(String room, String object) {
    final name = room.toLowerCase();
    switch (object) {
      case 'Bed':
        return name.contains('bedroom') || name.contains('bedrooms');
      case 'Television':
        return name.contains('living') ||
            name.contains('lounge') ||
            name.contains('break') ||
            name.contains('office');
      case 'Bookshelf':
        return name.contains('office') ||
            name.contains('study') ||
            name.contains('archive') ||
            name.contains('records') ||
            name.contains('library');
      case 'Statue':
        return name.contains('gallery') ||
            name.contains('sculpture') ||
            name.contains('lobby');
      case 'Box':
        return name.contains('storage') ||
            name.contains('freezer') ||
            name.contains('archive') ||
            name.contains('records');
      case 'Table':
        return !name.contains('bathroom');
      case 'Plant':
        return !name.contains('bathroom') && !name.contains('freezer');
      case 'Fireplace':
        return name.contains('lounge') ||
            name.contains('living') ||
            name.contains('lodge') ||
            name.contains('bedroom');
      default:
        return true;
    }
  }

  final solutionCells = level.solution.values.toSet();
  final result = <int, BoardObject>{};
  for (var index = 0; index < cells.length; index++) {
    final cell = cells[index];
    final room = layout.roomAt(cell);
    final eligible = objects
        .where(
          (object) =>
              roomAllowsObject(room, object.name) &&
              (object.name != 'Window' || isOutsideWall(cell)),
        )
        .toList();
    final placementEligible = solutionCells.contains(cell)
        ? eligible.where((object) => object.occupiable).toList()
        : eligible;
    final choices = placementEligible.isEmpty ? eligible : placementEligible;
    result[cell] = choices[(index + level.number) % choices.length];
  }
  if (level.number == 2) {
    result[19] = objects.firstWhere((object) => object.name == 'Bed');
    result[25] = objects.firstWhere((object) => object.name == 'Plant');
  }
  return result;
}

bool _cellsAreAdjacent(int first, int second, int size) {
  final firstRow = first ~/ size;
  final firstColumn = first % size;
  final secondRow = second ~/ size;
  final secondColumn = second % size;
  return (firstRow - secondRow).abs() + (firstColumn - secondColumn).abs() == 1;
}

bool objectCluesMatch(Level level, Map<String, int> solution) {
  final objects = objectsFor(level);
  final layout = layoutFor(level);
  for (final clue in level.clues) {
    final match = RegExp(
      r'^(\w+) was beside an? (\w+) and was in an? (chair|bed)\.',
      caseSensitive: false,
    ).firstMatch(clue);
    if (match == null) continue;
    final personCell = solution[match.group(1)!];
    final objectName = match.group(2)!.toLowerCase();
    final seatName = match.group(3)!.toLowerCase();
    if (personCell == null) return false;
    BoardObject? seatObject;
    int? referencedCell;
    for (final entry in objects.entries) {
      if (entry.key == personCell &&
          entry.value.name.toLowerCase() == seatName) {
        seatObject = entry.value;
      }
      if (entry.value.name.toLowerCase() == objectName) {
        referencedCell = entry.key;
      }
    }
    if (seatObject == null || referencedCell == null) return false;
    if (layout.roomAt(personCell) != layout.roomAt(referencedCell) ||
        !_cellsAreAdjacent(personCell, referencedCell, level.gridSize)) {
      return false;
    }
  }
  return true;
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late final Map<String, int?> placed;
  late final Map<String, int> answer;
  late final Map<int, Set<String>> notes;
  String? activeSuspect;
  String? selectedMurderer;
  bool notesMode = false;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    answer = solutionFor(widget.level);
    placed = {for (final name in answer.keys) name: null};
    notes = {
      for (
        var cell = 0;
        cell < widget.level.gridSize * widget.level.gridSize;
        cell++
      )
        cell: <String>{},
    };
  }

  String? occupantAt(int cell) => placed.entries
      .where((entry) => entry.value == cell)
      .map((entry) => entry.key)
      .firstOrNull;

  void tapCell(int cell) {
    final object = objectsFor(widget.level)[cell];
    final blocked =
        widget.level.blocked.contains(cell) && !(object?.occupiable ?? false);
    final occupant = occupantAt(cell);
    if (blocked) return;
    setState(() {
      if (!notesMode &&
          occupant != null &&
          (activeSuspect == null || occupant == activeSuspect)) {
        placed[occupant] = null;
        notes[cell]!.clear();
        activeSuspect = null;
        checked = false;
        return;
      }
      if (activeSuspect == null) return;
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
        for (final noteSet in notes.values) {
          noteSet.remove(suspect);
        }
        activeSuspect = null;
      }
      checked = false;
    });
  }

  void check() {
    final complete = placed.values.every((value) => value != null);
    final victimCell = placed[widget.level.victim];
    final victimRoom = victimCell == null
        ? ''
        : layoutFor(widget.level).roomAt(victimCell);
    final victimHasRoommate =
        victimCell != null &&
        placed.entries.any(
          (entry) =>
              entry.key != widget.level.victim &&
              entry.value != null &&
              layoutFor(widget.level).roomAt(entry.value!) == victimRoom,
        );
    final correct =
        complete &&
        victimHasRoommate &&
        objectCluesMatch(widget.level, answer) &&
        placed.entries.every((entry) => answer[entry.key] == entry.value);
    final murderer = murdererFor(widget.level, answer);
    final murdererCorrect = selectedMurderer == murderer;
    setState(() => checked = true);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          correct && murdererCorrect
              ? 'Case solved'
              : complete && !murdererCorrect
              ? 'Murderer not identified'
              : complete && !victimHasRoommate
              ? 'Victim cannot be alone'
              : complete
              ? 'Not quite'
              : 'Keep investigating',
        ),
        content: Text(
          correct && murdererCorrect
              ? 'Excellent deduction. ${widget.level.victim} was not alone.'
              : complete && !murdererCorrect
              ? 'The murderer was $murderer. Revisit the room containing the victim.'
              : complete && !victimHasRoommate
              ? 'The victim must share a room with at least one suspect.'
              : complete
              ? 'One or more suspects are in the wrong cell. Re-read the clues and try again.'
              : 'Place every character, including the victim, and choose who you think is the murderer.',
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
        ],
      ),
      actions: [
        TextButton(onPressed: check, child: const Text('CHECK SOLUTION')),
      ],
    ),
    body: Column(
      children: [
        Expanded(
          child: Center(
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
                    onSuspectTap: (name) =>
                        setState(() => activeSuspect = name),
                    notesMode: notesMode,
                    onModeChanged: (value) => setState(() => notesMode = value),
                    selectedMurderer: selectedMurderer,
                    onMurdererChanged: (name) =>
                        setState(() => selectedMurderer = name),
                  );
                  return Padding(
                    padding: const EdgeInsets.all(28),
                    child: wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 5, child: grid),
                              const SizedBox(width: 30),
                              Expanded(
                                flex: 4,
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: clues,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                grid,
                                const SizedBox(height: 30),
                                clues,
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => showRulesDialog(context),
                  tooltip: 'Game rules',
                  icon: const Icon(Icons.info_outline_rounded),
                  color: brickDark,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    activeSuspect == null
                        ? 'Select a suspect, then choose a cell. Tap a placed suspect to remove it.'
                        : notesMode
                        ? 'Tap cells to add or remove a candidate note for $activeSuspect.'
                        : 'Tap an open cell to place $activeSuspect.',
                    style: const TextStyle(color: ink),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: level.gridSize,
                    ),
                    itemCount: level.gridSize * level.gridSize,
                    itemBuilder: (context, index) {
                      final objects = objectsFor(level);
                      final name = occupantAt(index);
                      final cellNotes = notes[index] ?? <String>{};
                      final room = layout.roomAt(index);
                      final object = objects[index];
                      final blocked =
                          level.blocked.contains(index) &&
                          !(object?.occupiable ?? false);
                      final row = index ~/ level.gridSize;
                      final column = index % level.gridSize;
                      final eliminatedByPlacement =
                          name == null &&
                          !blocked &&
                          placed.values.any(
                            (cell) =>
                                cell != null &&
                                ((cell ~/ level.gridSize) == row ||
                                    (cell % level.gridSize) == column),
                          );
                      final topRoom = layout.roomAt(index - level.gridSize);
                      final leftRoom = index % level.gridSize == 0
                          ? ''
                          : layout.roomAt(index - 1);
                      final rightRoom =
                          index % level.gridSize == level.gridSize - 1
                          ? ''
                          : layout.roomAt(index + 1);
                      final bottomRoom = layout.roomAt(index + level.gridSize);
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
                                : notesMode && activeSuspect != null
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
                                    : object != null &&
                                          (!object.occupiable || !notesMode)
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
                                        child: Column(
                                          children: List.generate(
                                            3,
                                            (row) => Expanded(
                                              child: Row(
                                                children: List.generate(3, (
                                                  column,
                                                ) {
                                                  final noteIndex =
                                                      row * 3 + column;
                                                  final candidate =
                                                      noteIndex <
                                                          level.suspects.length
                                                      ? level
                                                            .suspects[noteIndex]
                                                      : null;
                                                  return Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        candidate != null &&
                                                                cellNotes
                                                                    .contains(
                                                                      candidate,
                                                                    )
                                                            ? candidate
                                                                  .substring(
                                                                    0,
                                                                    1,
                                                                  )
                                                                  .toUpperCase()
                                                            : '',
                                                        style: const TextStyle(
                                                          color: brickDark,
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
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
                  final left = firstCell % level.gridSize < level.gridSize / 2
                      ? 6.0
                      : constraints.maxWidth / 2 + 6;
                  final top = firstCell ~/ level.gridSize < level.gridSize / 2
                      ? -26.0
                      : constraints.maxHeight + 5;
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
    required this.selectedMurderer,
    required this.onMurdererChanged,
  });
  final Level level;
  final Map<String, int?> placed;
  final String? activeSuspect;
  final ValueChanged<String> onSuspectTap;
  final bool notesMode;
  final ValueChanged<bool> onModeChanged;
  final String? selectedMurderer;
  final ValueChanged<String> onMurdererChanged;
  @override
  Widget build(BuildContext context) {
    final guideObjects = objectsFor(level).values.toSet().toList();
    final sortedClues = [...level.clues]
      ..sort((a, b) {
        int suspectOrder(String clue) {
          final index = level.suspects.indexWhere(
            (name) => clue.toLowerCase().startsWith(name.toLowerCase()),
          );
          return index == -1 ? level.suspects.length : index;
        }

        return suspectOrder(a).compareTo(suspectOrder(b));
      });
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
          'CHARACTERS',
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
          children: [...level.suspects, level.victim]
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
          'WHO IS THE MURDERER?',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: ink,
          ),
        ),
        const SizedBox(height: 9),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: level.suspects
              .map(
                (name) => ChoiceChip(
                  label: Text(name),
                  selected: selectedMurderer == name,
                  onSelected: (_) => onMurdererChanged(name),
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
        ...sortedClues.asMap().entries.map(
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
