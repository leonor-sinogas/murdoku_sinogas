import 'package:flutter/material.dart';

const ink = Color(0xFF072D33);
const mauve = Color(0xFF9ABCAB);
const coral = Color(0xFF8F5C64);
const brick = Color(0xFF3A7564);
const brickDark = Color(0xFF33091B);
const paper = Color(0xFFF7F4F1);

void main() => runApp(const MurdokuApp());

class MurdokuApp extends StatefulWidget {
  const MurdokuApp({super.key});

  @override
  State<MurdokuApp> createState() => _MurdokuAppState();
}

class _MurdokuAppState extends State<MurdokuApp> {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeData _theme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? const Color(0xFF061B20) : paper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: coral,
        brightness: brightness,
        surface: isDark ? const Color(0xFF0D2C32) : paper,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? const Color(0xFFF7F4F1) : ink,
      ),
      fontFamily: 'Arial',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      mode: _themeMode,
      onChanged: (mode) => setState(() => _themeMode = mode),
      child: MaterialApp(
        title: 'Murdoku',
        debugShowCheckedModeBanner: false,
        theme: _theme(Brightness.light),
        darkTheme: _theme(Brightness.dark),
        themeMode: _themeMode,
        home: const HomeScreen(),
      ),
    );
  }
}

class ThemeController extends InheritedWidget {
  const ThemeController({
    required this.mode,
    required this.onChanged,
    required super.child,
    super.key,
  });

  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;

  static ThemeController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeController>()!;

  @override
  bool updateShouldNotify(ThemeController oldWidget) => mode != oldWidget.mode;
}

class _ThemeMenu extends StatelessWidget {
  const _ThemeMenu();

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.of(context);
    final icon = switch (controller.mode) {
      ThemeMode.light => Icons.light_mode_rounded,
      ThemeMode.dark => Icons.dark_mode_rounded,
      ThemeMode.system => Icons.brightness_auto_rounded,
    };
    return PopupMenuButton<ThemeMode>(
      tooltip: 'Choose theme',
      icon: Icon(icon),
      onSelected: controller.onChanged,
      itemBuilder: (context) => [
        const PopupMenuItem(value: ThemeMode.system, child: Text('System')),
        const PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
        const PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
      ],
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
    required List<String> clues,
    required this.solution,
    required this.blocked,
    this.fixedObjects = const {},
    this.gridSize = 6,
  }) : _clues = clues;

  final int number;
  final String name;
  final String tagline;
  final String location;
  final String victim;
  final List<String> suspects;
  final List<String> _clues;
  List<String> get clues {
    if (number < 11 || suspects.length != 5 || gridSize != 6) return _clues;
    final first = suspects[0];
    final second = suspects[1];
    final third = suspects[2];
    final fourth = suspects[3];
    final fifth = suspects[4];
    return [
      '$first was in the first row and west of $second.',
      '$second was in the second row and west of $third.',
      '$third was in the fourth row and third column, west of $fourth.',
      '$fourth was in the third row and fifth column, west of $fifth.',
      '$fifth was in the fifth row.',
      'The victim was in the final available cell.',
    ];
  }

  final Map<String, int> solution;
  final Set<int> blocked;
  final Map<int, String> fixedObjects;
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
      'Andre': 9,
      'Bethany': 19,
      'Clyde': 2,
      'Delilah': 35,
      'Eduardo': 40,
      'Felicia': 50,
      'Greg': 60,
      'Helena': 70,
    },
    blocked: {1, 2, 4, 13, 22, 31, 39, 49, 56, 67, 76, 79},
  ),
  Level(
    number: 2,
    name: 'Vacation House',
    tagline: 'The bloodstains are not coming out of the Airbnb rug.',
    location: 'Holiday home',
    victim: 'Virgil',
    suspects: ['Arianna', 'Brycen', 'Colleen', 'Dan', 'Evan'],
    clues: [
      'Arianna was beside a television.',
      'Brycen was sitting in a chair.',
      'Colleen was in the bathroom and in the third row.',
      'Dan was beside a plant and was in a bed.',
      'Evan was beside a bed.',
      'The victim was in the last available cell.',
    ],
    solution: {
      'Arianna': 35,
      'Brycen': 6,
      'Colleen': 15,
      'Dan': 19,
      'Evan': 26,
    },
    blocked: {0, 3, 9, 12, 16, 17, 18, 19, 20, 25, 28, 29, 34},
    fixedObjects: {
      6: 'Chair',
      9: 'Table',
      16: 'Table',
      17: 'Table',
      18: 'Plant',
      19: 'Bed',
      24: 'Table',
      25: 'Bed',
      28: 'Table',
      33: 'Table',
      34: 'Television',
    },
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
    solution: {'Aaron': 2, 'Bruno': 15, 'Clara': 11, 'Donna': 24, 'Evelyn': 34},
    blocked: {1, 4, 6, 11, 13, 16, 22, 25, 28, 30, 35},
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
      'Ashton': 29,
      'Blaine': 10,
      'Carla': 2,
      'Delilah': 47,
      'Estella': 21,
      'Frank': 18,
      'Galen': 41,
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
      'Iris': 14,
      'Jonah': 7,
      'Kendall': 5,
      'Luca': 21,
      'Mina': 28,
      'Nico': 30,
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
      'Silas was not in the Main Gallery.',
      'The victim was in the last available cell.',
    ],
    solution: {
      'Avery': 0,
      'Beck': 7,
      'Cora': 16,
      'Dylan': 23,
      'Mae': 26,
      'Silas': 33,
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
      'Ayla': 0,
      'Bram': 7,
      'Cleo': 16,
      'Jasper': 26,
      'Nora': 23,
      'Otto': 33,
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
      'June': 26,
      'Kira': 7,
      'Miles': 23,
      'Reese': 4,
      'Sana': 30,
      'Toby': 15,
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
      'Cass': 16,
      'Drew': 23,
      'Elle': 26,
      'Fox': 33,
    },
    blocked: {0, 4, 9, 11, 16, 18, 23, 27, 30, 34},
  ),
  Level(
    number: 11,
    name: 'The Museum After Dark',
    tagline: 'The exhibits were silent. The witnesses were not.',
    location: 'Museum',
    victim: 'Fiona',
    suspects: ['Aiden', 'Beatrice', 'Cole', 'Delia', 'Emery'],
    clues: [
      'Aiden was in the first row and first column.',
      'Beatrice was in the second row and second column.',
      'Cole was south of Beatrice.',
      'Delia was in the third row and fifth column.',
      'Emery was east of Cole.',
      'The victim was in the final available cell.',
    ],
    solution: {'Aiden': 0, 'Beatrice': 7, 'Cole': 20, 'Delia': 16, 'Emery': 29},
    blocked: {1, 4, 8, 10, 13, 16, 18, 23, 26, 31},
  ),
  Level(
    number: 12,
    name: 'The Sleeper Car',
    tagline: 'Someone boarded the train. Someone never got off.',
    location: 'Night train',
    victim: 'Juno',
    suspects: ['Briar', 'Callum', 'Daphne', 'Elias', 'Freya'],
    clues: [
      'Briar was in the first row and first column.',
      'Callum was in the second row and second column.',
      'Daphne was south of Callum.',
      'Elias was in the third row and fifth column.',
      'Freya was east of Daphne.',
      'The victim was in the final available cell.',
    ],
    solution: {'Briar': 0, 'Callum': 7, 'Daphne': 20, 'Elias': 16, 'Freya': 29},
    blocked: {2, 5, 8, 11, 13, 17, 19, 24, 30, 33},
  ),
  Level(
    number: 13,
    name: 'The County Courthouse',
    tagline: 'The verdict was still out when the lights went off.',
    location: 'Courthouse',
    victim: 'Gideon',
    suspects: ['Avery', 'Bruno', 'Clara', 'Dorian', 'Elise'],
    clues: [
      'Avery was in the first row and first column.',
      'Bruno was in the second row and second column.',
      'Clara was south of Bruno.',
      'Dorian was in the third row and fifth column.',
      'Elise was east of Clara.',
      'The victim was in the final available cell.',
    ],
    solution: {'Avery': 0, 'Bruno': 7, 'Clara': 20, 'Dorian': 16, 'Elise': 29},
    blocked: {1, 3, 9, 12, 16, 18, 22, 25, 29, 34},
  ),
  Level(
    number: 14,
    name: 'The Garden Party',
    tagline: 'The invitations were elegant. The alibis were not.',
    location: 'Estate',
    victim: 'Harper',
    suspects: ['Amelia', 'Bennett', 'Celia', 'Davis', 'Evelyn'],
    clues: [
      'Amelia was in the first row and first column.',
      'Bennett was in the second row and second column.',
      'Celia was south of Bennett.',
      'Davis was in the third row and fifth column.',
      'Evelyn was east of Celia.',
      'The victim was in the final available cell.',
    ],
    solution: {
      'Amelia': 0,
      'Bennett': 7,
      'Celia': 20,
      'Davis': 16,
      'Evelyn': 29,
    },
    blocked: {2, 4, 8, 10, 15, 17, 20, 24, 27, 32},
  ),
  Level(
    number: 15,
    name: 'The Night Clinic',
    tagline: 'The waiting room was empty. The mystery was not.',
    location: 'Clinic',
    victim: 'Iris',
    suspects: ['Archer', 'Bianca', 'Carter', 'Demi', 'Evan'],
    clues: [
      'Archer was in the first row and first column.',
      'Bianca was in the second row and second column.',
      'Carter was south of Bianca.',
      'Demi was in the third row and fifth column.',
      'Evan was east of Carter.',
      'The victim was in the final available cell.',
    ],
    solution: {'Archer': 0, 'Bianca': 7, 'Carter': 20, 'Demi': 16, 'Evan': 29},
    blocked: {1, 5, 9, 11, 16, 19, 23, 26, 30, 34},
  ),
  Level(
    number: 16,
    name: 'The Recording Studio',
    tagline: 'The final track had one voice too many.',
    location: 'Studio',
    victim: 'Nora',
    suspects: ['Ari', 'Blake', 'Carmen', 'Devon', 'Etta'],
    clues: [
      'Ari was in the first row and first column.',
      'Blake was in the second row and second column.',
      'Carmen was south of Blake.',
      'Devon was in the third row and fifth column.',
      'Etta was east of Carmen.',
      'The victim was in the final available cell.',
    ],
    solution: {'Ari': 0, 'Blake': 7, 'Carmen': 20, 'Devon': 16, 'Etta': 29},
    blocked: {2, 3, 8, 12, 15, 18, 22, 25, 29, 33},
  ),
  Level(
    number: 17,
    name: 'The Harbor Ferry',
    tagline: 'The tide came in. The truth came out.',
    location: 'Ferry',
    victim: 'Milo',
    suspects: ['Ada', 'Beck', 'Cleo', 'Drew', 'Faye'],
    clues: [
      'Ada was in the first row and first column.',
      'Beck was in the second row and second column.',
      'Cleo was south of Beck.',
      'Drew was in the third row and fifth column.',
      'Faye was east of Cleo.',
      'The victim was in the final available cell.',
    ],
    solution: {'Ada': 0, 'Beck': 7, 'Cleo': 20, 'Drew': 16, 'Faye': 29},
    blocked: {1, 4, 9, 13, 16, 20, 23, 27, 31, 34},
  ),
  Level(
    number: 18,
    name: 'The Boarding School',
    tagline: 'The bell rang once. Then the halls went quiet.',
    location: 'School',
    victim: 'Greta',
    suspects: ['Alina', 'Boris', 'Chloe', 'Derek', 'Elsa'],
    clues: [
      'Alina was in the first row and first column.',
      'Boris was in the second row and second column.',
      'Chloe was south of Boris.',
      'Derek was in the third row and fifth column.',
      'Elsa was east of Chloe.',
      'The victim was in the final available cell.',
    ],
    solution: {'Alina': 0, 'Boris': 7, 'Chloe': 20, 'Derek': 16, 'Elsa': 29},
    blocked: {2, 5, 8, 11, 17, 19, 24, 26, 30, 32},
  ),
  Level(
    number: 19,
    name: 'The Grand Theater',
    tagline: 'The curtain rose on a scene nobody rehearsed.',
    location: 'Theater',
    victim: 'Holly',
    suspects: ['Anton', 'Bella', 'Cyrus', 'Dahlia', 'Enzo'],
    clues: [
      'Anton was in the first row and first column.',
      'Bella was in the second row and second column.',
      'Cyrus was south of Bella.',
      'Dahlia was in the third row and fifth column.',
      'Enzo was east of Cyrus.',
      'The victim was in the final available cell.',
    ],
    solution: {'Anton': 0, 'Bella': 7, 'Cyrus': 20, 'Dahlia': 16, 'Enzo': 29},
    blocked: {1, 3, 10, 12, 15, 18, 22, 27, 29, 33},
  ),
  Level(
    number: 20,
    name: 'The Research Annex',
    tagline: 'The experiment ended. The questions multiplied.',
    location: 'Research center',
    victim: 'Ivo',
    suspects: ['Anya', 'Brent', 'Cleo', 'Damon', 'Esme'],
    clues: [
      'Anya was in the first row and first column.',
      'Brent was in the second row and second column.',
      'Cleo was south of Brent.',
      'Damon was in the third row and fifth column.',
      'Esme was east of Cleo.',
      'The victim was in the final available cell.',
    ],
    solution: {'Anya': 0, 'Brent': 7, 'Cleo': 20, 'Damon': 16, 'Esme': 29},
    blocked: {2, 4, 8, 13, 16, 19, 23, 25, 31, 34},
  ),
  Level(
    number: 21,
    name: 'The Lakeside Cottage',
    tagline: 'The view was peaceful. The weekend was not.',
    location: 'Cottage',
    victim: 'June',
    suspects: ['Avery', 'Brooke', 'Casey', 'Dylan', 'Emilia'],
    clues: [
      'Avery was in the first row and first column.',
      'Brooke was in the second row and second column.',
      'Casey was south of Brooke.',
      'Dylan was in the third row and fifth column.',
      'Emilia was east of Casey.',
      'The victim was in the final available cell.',
    ],
    solution: {'Avery': 0, 'Brooke': 7, 'Casey': 20, 'Dylan': 16, 'Emilia': 29},
    blocked: {1, 5, 9, 11, 17, 20, 24, 26, 30, 32},
  ),
  Level(
    number: 22,
    name: 'The Executive Retreat',
    tagline: 'The presentation was polished. The murder was not.',
    location: 'Retreat center',
    victim: 'Rowan',
    suspects: ['Alec', 'Bria', 'Cora', 'Dean', 'Elena'],
    clues: [
      'Alec was in the first row and first column.',
      'Bria was in the second row and second column.',
      'Cora was south of Bria.',
      'Dean was in the third row and fifth column.',
      'Elena was east of Cora.',
      'The victim was in the final available cell.',
    ],
    solution: {'Alec': 0, 'Bria': 7, 'Cora': 20, 'Dean': 16, 'Elena': 29},
    blocked: {2, 3, 8, 12, 15, 18, 22, 27, 29, 33},
  ),
  Level(
    number: 23,
    name: 'The Bakery Before Dawn',
    tagline: 'The ovens were warm. The back door was open.',
    location: 'Bakery',
    victim: 'Pia',
    suspects: ['Abel', 'Bridget', 'Celia', 'Dario', 'Eve'],
    clues: [
      'Abel was in the first row and first column.',
      'Bridget was in the second row and second column.',
      'Celia was south of Bridget.',
      'Dario was in the third row and fifth column.',
      'Eve was east of Celia.',
      'The victim was in the final available cell.',
    ],
    solution: {'Abel': 0, 'Bridget': 7, 'Celia': 20, 'Dario': 16, 'Eve': 29},
    blocked: {1, 4, 9, 13, 16, 19, 23, 25, 31, 34},
  ),
  Level(
    number: 24,
    name: 'The Penthouse Party',
    tagline: 'The skyline glittered while the secrets surfaced.',
    location: 'Penthouse',
    victim: 'Sloane',
    suspects: ['Arden', 'Blair', 'Cleo', 'Dante', 'Elle'],
    clues: [
      'Arden was in the first row and first column.',
      'Blair was in the second row and second column.',
      'Cleo was south of Blair.',
      'Dante was in the third row and fifth column.',
      'Elle was east of Cleo.',
      'The victim was in the final available cell.',
    ],
    solution: {'Arden': 0, 'Blair': 7, 'Cleo': 20, 'Dante': 16, 'Elle': 29},
    blocked: {2, 5, 10, 12, 17, 20, 24, 26, 30, 32},
  ),
  Level(
    number: 25,
    name: 'The Natural History Wing',
    tagline: 'The fossils were ancient. The motive was fresh.',
    location: 'Museum',
    victim: 'Mara',
    suspects: ['Asha', 'Bruno', 'Celia', 'Drew', 'Esther'],
    clues: [
      'Asha was in the first row and first column.',
      'Bruno was in the second row and second column.',
      'Celia was south of Bruno.',
      'Drew was in the third row and fifth column.',
      'Esther was east of Celia.',
      'The victim was in the final available cell.',
    ],
    solution: {'Asha': 0, 'Bruno': 7, 'Celia': 20, 'Drew': 16, 'Esther': 29},
    blocked: {1, 3, 8, 11, 15, 18, 22, 27, 29, 33},
  ),
  Level(
    number: 26,
    name: 'The Harvest Supper',
    tagline: 'Everyone came for dinner. Not everyone left.',
    location: 'Farmhouse',
    victim: 'Nell',
    suspects: ['Ada', 'Bea', 'Clara', 'Della', 'Eli'],
    clues: [
      'Ada was in the first row and first column.',
      'Bea was in the second row and second column.',
      'Clara was south of Bea.',
      'Della was in the third row and fifth column.',
      'Eli was east of Clara.',
      'The victim was in the final available cell.',
    ],
    solution: {'Ada': 0, 'Bea': 7, 'Clara': 20, 'Della': 16, 'Eli': 29},
    blocked: {2, 4, 9, 13, 16, 19, 23, 26, 31, 34},
  ),
  Level(
    number: 27,
    name: 'The Casino Floor',
    tagline: 'The house always wins. Tonight, so did the murderer.',
    location: 'Casino',
    victim: 'Rhea',
    suspects: ['Alma', 'Blaise', 'Cora', 'Dane', 'Eden'],
    clues: [
      'Alma was in the first row and first column.',
      'Blaise was in the second row and second column.',
      'Cora was south of Blaise.',
      'Dane was in the third row and fifth column.',
      'Eden was east of Cora.',
      'The victim was in the final available cell.',
    ],
    solution: {'Alma': 0, 'Blaise': 7, 'Cora': 20, 'Dane': 16, 'Eden': 29},
    blocked: {1, 5, 8, 12, 17, 20, 24, 25, 30, 32},
  ),
  Level(
    number: 28,
    name: 'The Independent Bookshop',
    tagline: 'The rarest thing in the shop was an honest alibi.',
    location: 'Bookshop',
    victim: 'Faye',
    suspects: ['Anika', 'Bram', 'Cleo', 'Daria', 'Evan'],
    clues: [
      'Anika was in the first row and first column.',
      'Bram was in the second row and second column.',
      'Cleo was south of Bram.',
      'Daria was in the third row and fifth column.',
      'Evan was east of Cleo.',
      'The victim was in the final available cell.',
    ],
    solution: {'Anika': 0, 'Bram': 7, 'Cleo': 20, 'Daria': 16, 'Evan': 29},
    blocked: {2, 3, 10, 11, 15, 18, 22, 27, 29, 33},
  ),
  Level(
    number: 29,
    name: 'The Beach House Weekend',
    tagline: 'The tide went out. The truth came in.',
    location: 'Beach house',
    victim: 'Wren',
    suspects: ['Avery', 'Brody', 'Celia', 'Damon', 'Elsie'],
    clues: [
      'Avery was in the first row and first column.',
      'Brody was in the second row and second column.',
      'Celia was south of Brody.',
      'Damon was in the third row and fifth column.',
      'Elsie was east of Celia.',
      'The victim was in the final available cell.',
    ],
    solution: {'Avery': 0, 'Brody': 7, 'Celia': 20, 'Damon': 16, 'Elsie': 29},
    blocked: {1, 4, 9, 13, 16, 19, 23, 26, 31, 34},
  ),
  Level(
    number: 30,
    name: 'The Hotel Convention',
    tagline: 'The keynote was cancelled. The investigation was not.',
    location: 'Hotel',
    victim: 'Quinn',
    suspects: ['Ari', 'Bria', 'Carmen', 'Derek', 'Elena'],
    clues: [
      'Ari was in the first row and first column.',
      'Bria was in the second row and second column.',
      'Carmen was south of Bria.',
      'Derek was in the third row and fifth column.',
      'Elena was east of Carmen.',
      'The victim was in the final available cell.',
    ],
    solution: {'Ari': 0, 'Bria': 7, 'Carmen': 20, 'Derek': 16, 'Elena': 29},
    blocked: {2, 5, 8, 12, 17, 20, 24, 27, 30, 32},
  ),
];

// Ordered from the most approachable cases to the most involved deduction.
const levelOrder = <int>[
  1,
  2,
  9,
  7,
  6,
  5,
  4,
  8,
  3,
  0,
  ...<int>[
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
  ],
];

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
      actions: const [_ThemeMenu()],
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
          'Use the clues to place every suspect in a unique available cell. The victim must share a room with exactly one suspect; that suspect is the murderer.',
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
              'Each suspect occupies one row, one column, and one available cell. The victim’s room must contain exactly one suspect. Thick borders separate the named rooms.',
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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
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
            color: isDark ? paper : ink,
          ),
        ),
        const Spacer(),
        const _ThemeMenu(),
        const SizedBox(width: 4),
        Text(
          'CASE FILES  •  30',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? mauve : const Color(0xFF78808D),
          ),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.onStart});
  final VoidCallback onStart;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Think like a detective.',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.03,
            color: isDark ? paper : ink,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Place every suspect on the grid, follow the clues, and discover who shared a room with the victim.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.45,
            color: isDark ? const Color(0xFFC5D4D6) : const Color(0xFF626B79),
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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF103239) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? brick : const Color(0xFFE6E0D8)),
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
                      style: TextStyle(
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
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: isDark ? paper : ink,
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

RoomLayout _sixBySixRooms(
  String northWest,
  String northEast,
  String southWest,
  String southEast,
) => RoomLayout({
  northWest: _rect(0, 2, 0, 2),
  northEast: _rect(0, 2, 3, 5),
  southWest: _rect(3, 5, 0, 2),
  southEast: _rect(3, 5, 3, 5),
});

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
    case 11:
      return _sixBySixRooms(
        'Main Gallery',
        'Sculpture Hall',
        'Archive',
        'Gift Shop',
      );
    case 12:
      return _sixBySixRooms('Cabins', 'Dining Car', 'Lounge', 'First Class');
    case 13:
      return _sixBySixRooms(
        'Main Office',
        'Evidence Room',
        'Interrogation',
        'Cell Block',
      );
    case 14:
      return _sixBySixRooms(
        'Kitchen',
        'Dining Room',
        'Guest Bedroom',
        'Garden',
      );
    case 15:
      return _sixBySixRooms(
        'Clinic',
        'Waiting Room',
        'Records',
        'Operating Room',
      );
    case 16:
      return _sixBySixRooms(
        'Recording Booths',
        'Control Room',
        'Green Room',
        'Backstage',
      );
    case 17:
      return _sixBySixRooms('Deck', 'Cabins', 'Dining Room', 'Engine Room');
    case 18:
      return _sixBySixRooms('Classrooms', 'Library', 'Cafeteria', 'Gymnasium');
    case 19:
      return _sixBySixRooms('Lobby', 'Theater', 'Dressing Rooms', 'Backstage');
    case 20:
      return _sixBySixRooms('Reception', 'Laboratory', 'Archive', 'Storage');
    case 21:
      return _sixBySixRooms(
        'Living Room',
        'Kitchen',
        'Main Bedroom',
        'Bathroom',
      );
    case 22:
      return _sixBySixRooms(
        'Boardroom',
        'Break Room',
        "Director's Office",
        'Records',
      );
    case 23:
      return _sixBySixRooms('Bakery', 'Cafe', 'Kitchen', 'Storage');
    case 24:
      return _sixBySixRooms('Rooftop', 'Penthouse', 'Office', 'Garage');
    case 25:
      return _sixBySixRooms('Museum', 'Sculpture Hall', 'Archive', 'Gift Shop');
    case 26:
      return _sixBySixRooms('Farmhouse', 'Kitchen', 'Barn', 'Guest Bedroom');
    case 27:
      return _sixBySixRooms('Casino Floor', 'VIP Lounge', 'Office', 'Vault');
    case 28:
      return _sixBySixRooms('Bookshop', 'Reading Room', 'Office', 'Stockroom');
    case 29:
      return _sixBySixRooms(
        'Living Room',
        'Kitchen',
        'Guest Bedroom',
        'Pool Deck',
      );
    case 30:
      return _sixBySixRooms(
        'Hotel Lobby',
        'Restaurant',
        'Guest Bedroom',
        'Conference Room',
      );
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
    if ((!level.blocked.contains(cell) && object?.occupiable != false) ||
        object?.occupiable == true) {
      available.add(cell);
    }
  }
  final suspectRooms = solution.values
      .map(layout.roomAt)
      .where((room) => room.isNotEmpty)
      .toSet();
  final suspectCountByRoom = <String, int>{};
  for (final cell in solution.values) {
    final room = layout.roomAt(cell);
    suspectCountByRoom[room] = (suspectCountByRoom[room] ?? 0) + 1;
  }
  final victimCell = available.reversed.firstWhere(
    (cell) =>
        suspectRooms.contains(layout.roomAt(cell)) &&
        suspectCountByRoom[layout.roomAt(cell)] == 1 &&
        !usedRows.contains(cell ~/ level.gridSize) &&
        !usedColumns.contains(cell % level.gridSize),
    orElse: () => available.reversed.firstWhere(
      (cell) =>
          suspectRooms.contains(layout.roomAt(cell)) &&
          suspectCountByRoom[layout.roomAt(cell)] == 1,
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

  if (level.fixedObjects.isNotEmpty) {
    for (final entry in level.fixedObjects.entries) {
      result[entry.key] = objects.firstWhere(
        (object) => object.name == entry.value,
      );
    }
    return result;
  }

  // Object placement is clue-aware. The old rotating assignment could put a
  // television, window, or plant somewhere unrelated to the clue that names
  // it (or omit that object entirely). Every referenced object is now placed
  // in the character's room, preferably in an adjacent cell.
  for (final clue in level.clues) {
    final person = cluePersonName(clue, level);
    final clueObjects = objectNamesInClue(clue);
    final objectName = clueObjects.isEmpty ? null : clueObjects.first;
    final personCell = person == null ? null : level.solution[person];
    if (objectName == null || personCell == null) continue;
    final object = objects.firstWhere((item) => item.name == objectName);
    final room = layout.roomAt(personCell);
    final sharesWindowCell =
        object.name == 'Window' &&
        RegExp(
          r'\b(beside|in front of)\b',
          caseSensitive: false,
        ).hasMatch(clue);
    final direction = RegExp(
      r'\b(east|west|north|south) of (?:the )?',
      caseSensitive: false,
    ).firstMatch(clue)?.group(1)?.toLowerCase();
    bool directionMatches(int cell) {
      if (direction == null) return true;
      final personRow = personCell ~/ size;
      final personColumn = personCell % size;
      final objectRow = cell ~/ size;
      final objectColumn = cell % size;
      return switch (direction) {
        'east' => personColumn > objectColumn,
        'west' => personColumn < objectColumn,
        'north' => personRow < objectRow,
        _ => personRow > objectRow,
      };
    }

    final adjacent = <int>[];
    for (var cell = 0; cell < size * size; cell++) {
      final sharesCell = sharesWindowCell && cell == personCell;
      if ((solutionCells.contains(cell) && !sharesCell) ||
          layout.roomAt(cell) != room) {
        continue;
      }
      if (!sharesCell &&
          directionMatches(cell) &&
          !_cellsAreAdjacent(personCell, cell, size)) {
        continue;
      }
      if (!sharesCell && !directionMatches(cell)) continue;
      if (!sharesCell &&
          direction == null &&
          !_cellsAreAdjacent(personCell, cell, size)) {
        continue;
      }
      if (object.name == 'Window' && !isOutsideWall(cell)) continue;
      adjacent.add(cell);
    }
    final fallback = <int>[];
    for (var cell = 0; cell < size * size; cell++) {
      final sharesCell = sharesWindowCell && cell == personCell;
      if ((solutionCells.contains(cell) && !sharesCell) ||
          layout.roomAt(cell) != room) {
        continue;
      }
      if (result[cell] != null && result[cell]!.name != objectName) continue;
      if (object.name == 'Window' && !isOutsideWall(cell)) continue;
      if (!directionMatches(cell)) continue;
      fallback.add(cell);
    }
    final openAdjacent = adjacent
        .where((cell) => result[cell] == null)
        .toList();
    final candidates = openAdjacent.isNotEmpty
        ? openAdjacent
        : adjacent.isNotEmpty
        ? adjacent
        : fallback;
    if (candidates.isNotEmpty) {
      final preferred = candidates.where(level.blocked.contains).toList();
      result[preferred.isNotEmpty ? preferred.first : candidates.first] =
          object;
    }
  }

  // A seated/lying clue identifies the occupiable object under the person,
  // even when that cell was not part of the original blocked set.
  final seatClue = RegExp(
    r'^(\w+) was .*?\b(chair|bed)\b',
    caseSensitive: false,
  );
  for (final clue in level.clues) {
    final match = seatClue.firstMatch(clue);
    if (match == null) continue;
    final cell = level.solution[match.group(1)!];
    if (cell == null) continue;
    result[cell] = objects.firstWhere(
      (item) => item.name.toLowerCase() == match.group(2)!.toLowerCase(),
    );
  }
  if (level.number == 2) {
    result[19] = objects.firstWhere((object) => object.name == 'Bed');
    result[18] = objects.firstWhere((object) => object.name == 'Plant');
    result[25] = objects.firstWhere((object) => object.name == 'Bed');
    result[29] = objects.firstWhere((object) => object.name == 'Television');
  }
  return result;
}

const _clueObjectNames = <String, String>{
  'television': 'Television',
  'bookshelf': 'Bookshelf',
  'fireplace': 'Fireplace',
  'statue': 'Statue',
  'window': 'Window',
  'plant': 'Plant',
  'table': 'Table',
  'chair': 'Chair',
  'bed': 'Bed',
  'box': 'Box',
};

Set<String> objectNamesInClue(String clue) {
  final lower = clue.toLowerCase();
  return _clueObjectNames.entries
      .where((entry) => lower.contains(entry.key))
      .map((entry) => entry.value)
      .toSet();
}

String? cluePersonName(String clue, Level level) {
  for (final person in [...level.suspects, level.victim]) {
    if (clue.toLowerCase().startsWith(person.toLowerCase())) return person;
  }
  return null;
}

Map<String, int> positionCluesFor(Level level) {
  const ordinals = {
    'first': 1,
    'second': 2,
    'third': 3,
    'fourth': 4,
    'fifth': 5,
    'sixth': 6,
    'seventh': 7,
    'eighth': 8,
    'ninth': 9,
  };
  final positions = <String, int>{};
  final pattern = RegExp(
    r'^(\w+) was in the (\w+) row and (\w+) column\.',
    caseSensitive: false,
  );
  for (final clue in level.clues) {
    final match = pattern.firstMatch(clue);
    if (match == null) continue;
    final row = ordinals[match.group(2)!.toLowerCase()];
    final column = ordinals[match.group(3)!.toLowerCase()];
    if (row != null && column != null) {
      positions[match.group(1)!] = (row - 1) * level.gridSize + column - 1;
    }
  }
  return positions;
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
    final relation = RegExp(
      r'^(\w+) was (?:beside|in front of) (?:an? |the )?(\w+)',
      caseSensitive: false,
    ).firstMatch(clue);
    if (relation != null) {
      final personCell = solution[relation.group(1)!];
      final objectName = _clueObjectNames[relation.group(2)!.toLowerCase()];
      if (personCell == null || objectName == null) return false;
      final matchingCells = objects.entries
          .where(
            (entry) =>
                entry.value.name == objectName &&
                layout.roomAt(entry.key) == layout.roomAt(personCell),
          )
          .map((entry) => entry.key);
      if (!matchingCells.any(
        (cell) =>
            cell == personCell ||
            _cellsAreAdjacent(personCell, cell, level.gridSize),
      )) {
        return false;
      }
    }
    final match = RegExp(
      r'^(\w+) was beside an? (\w+).*?\bwas in an? (chair|bed)\b',
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
        (referencedCell != personCell &&
            !_cellsAreAdjacent(personCell, referencedCell, level.gridSize))) {
      return false;
    }
  }
  return true;
}

class _PuzzleSnapshot {
  _PuzzleSnapshot({
    required this.placed,
    required this.notes,
    required this.manualXs,
    required this.activeSuspect,
  });

  final Map<String, int?> placed;
  final Map<int, Set<String>> notes;
  final Set<int> manualXs;
  final String? activeSuspect;
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late final Map<String, int?> placed;
  late final Map<String, int> answer;
  late final Map<int, Set<String>> notes;
  final List<_PuzzleSnapshot> _history = [];
  final Set<int> manualXs = <int>{};
  String? activeSuspect;
  String? selectedMurderer;
  bool notesMode = false;
  bool xMode = false;
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

  void _saveSnapshot() {
    _history.add(
      _PuzzleSnapshot(
        placed: Map<String, int?>.from(placed),
        notes: {
          for (final entry in notes.entries)
            entry.key: Set<String>.from(entry.value),
        },
        manualXs: Set<int>.from(manualXs),
        activeSuspect: activeSuspect,
      ),
    );
  }

  void undo() {
    if (_history.isEmpty) return;
    final snapshot = _history.removeLast();
    setState(() {
      placed
        ..clear()
        ..addAll(snapshot.placed);
      notes
        ..clear()
        ..addAll({
          for (final entry in snapshot.notes.entries)
            entry.key: Set<String>.from(entry.value),
        });
      manualXs
        ..clear()
        ..addAll(snapshot.manualXs);
      activeSuspect = snapshot.activeSuspect;
      checked = false;
    });
  }

  void clearPuzzle() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Start this puzzle over?'),
        content: const Text(
          'This will remove every placement, note, and personal X mark from the current puzzle.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                placed.updateAll((key, value) => null);
                for (final noteSet in notes.values) {
                  noteSet.clear();
                }
                manualXs.clear();
                _history.clear();
                activeSuspect = null;
                selectedMurderer = null;
                notesMode = false;
                xMode = false;
                checked = false;
              });
            },
            child: const Text('Start over'),
          ),
        ],
      ),
    );
  }

  void tapCell(int cell) {
    final object = objectsFor(widget.level)[cell];
    final blocked =
        (widget.level.blocked.contains(cell) ||
            object != null && !object.occupiable) &&
        !(object?.occupiable ?? false);
    final occupant = occupantAt(cell);
    if (xMode) {
      setState(() {
        if (manualXs.contains(cell)) {
          manualXs.remove(cell);
        } else {
          manualXs.add(cell);
        }
      });
      return;
    }
    if (blocked) return;
    setState(() {
      if (!notesMode &&
          occupant != null &&
          (activeSuspect == null || occupant == activeSuspect)) {
        _saveSnapshot();
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
        _saveSnapshot();
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
    if (selectedMurderer == null) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Choose a suspect'),
          content: Text(
            'Select who you think the murderer is, then submit your accusation.',
          ),
        ),
      );
      return;
    }
    final complete = placed.values.every((value) => value != null);
    final victimCell = placed[widget.level.victim];
    final victimRoom = victimCell == null
        ? ''
        : layoutFor(widget.level).roomAt(victimCell);
    final victimRoomSuspects = victimCell == null
        ? <String>[]
        : placed.entries
              .where(
                (entry) =>
                    entry.key != widget.level.victim &&
                    entry.value != null &&
                    layoutFor(widget.level).roomAt(entry.value!) == victimRoom,
              )
              .map((entry) => entry.key)
              .toList();
    final victimHasRoommate = victimRoomSuspects.length == 1;
    final correct =
        complete &&
        victimHasRoommate &&
        objectCluesMatch(widget.level, answer) &&
        placed.entries.every((entry) => answer[entry.key] == entry.value);
    final murderer = murdererFor(widget.level, answer);
    final murdererCorrect = selectedMurderer == murderer;
    final murdererFound = complete && victimHasRoommate && murdererCorrect;
    final exactSolve = correct && murdererCorrect;
    setState(() => checked = true);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          murdererFound
              ? 'Congratulations!'
              : complete && !murdererCorrect
              ? '$selectedMurderer was not the murderer'
              : complete && !victimHasRoommate
              ? 'Check the victim’s room'
              : complete
              ? 'Not quite'
              : 'Keep investigating',
        ),
        content: murdererFound
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎉  🎊  🎉', style: TextStyle(fontSize: 34)),
                  const SizedBox(height: 12),
                  Text(
                    exactSolve
                        ? 'You found the murderer!'
                        : 'You found the murderer in a peculiar way. Not everyone is in the correct spot, but you still got it!',
                  ),
                ],
              )
            : Text(
                complete && !murdererCorrect
                    ? '$selectedMurderer was not the murderer. Look at the clues again and find the real killer.'
                    : complete && !victimHasRoommate
                    ? 'The victim must be in a room with exactly one suspect.'
                    : complete
                    ? 'One or more suspects are in the wrong cell. Re-read the clues and try again.'
                    : 'Place every character, including the victim, before submitting your accusation.',
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
        const _ThemeMenu(),
        IconButton(
          onPressed: _history.isEmpty ? null : undo,
          tooltip: 'Undo last placement',
          icon: const Icon(Icons.undo_rounded),
        ),
        IconButton(
          onPressed: clearPuzzle,
          tooltip: 'Clear puzzle',
          icon: const Icon(Icons.restart_alt_rounded),
        ),
        TextButton(onPressed: check, child: const Text('SUBMIT ACCUSATION')),
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
                    xMode: xMode,
                    manualXs: manualXs,
                  );
                  final clues = _Clues(
                    level: widget.level,
                    placed: placed,
                    activeSuspect: activeSuspect,
                    onSuspectTap: (name) =>
                        setState(() => activeSuspect = name),
                    notesMode: notesMode,
                    xMode: xMode,
                    onModeChanged: (value) => setState(() {
                      notesMode = value == 'notes';
                      xMode = value == 'x';
                    }),
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
                        ? xMode
                              ? 'Tap cells to add or remove your own X marks.'
                              : 'Select a suspect, then choose a cell. Tap a placed suspect to remove it.'
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
    required this.xMode,
    required this.manualXs,
  });
  final Level level;
  final Map<String, int?> placed;
  final String? Function(int) occupantAt;
  final String? activeSuspect;
  final ValueChanged<int> onCellTap;
  final Map<int, Set<String>> notes;
  final bool notesMode;
  final bool xMode;
  final Set<int> manualXs;
  @override
  Widget build(BuildContext context) {
    final roomLayout = layoutFor(level);
    final roomNames = roomLayout.rooms.keys.toList();
    int roomWidth(String room) {
      final columns = roomLayout.rooms[room]!.map(
        (cell) => cell % level.gridSize,
      );
      return columns.reduce((a, b) => a > b ? a : b) -
          columns.reduce((a, b) => a < b ? a : b) +
          1;
    }

    Widget roomLabel(String room, TextAlign alignment) => Flexible(
      flex: roomWidth(room),
      child: Text(
        room,
        textAlign: alignment,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
    Widget roomRow(List<String> rooms) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          roomLabel(rooms[0], TextAlign.left),
          roomLabel(rooms[1], TextAlign.left),
        ],
      ),
    );
    return Column(
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
        roomRow(roomNames.take(2).toList()),
        const SizedBox(height: 6),
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
                            (level.blocked.contains(index) ||
                                object != null && !object.occupiable) &&
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
                        final bottomRoom = layout.roomAt(
                          index + level.gridSize,
                        );
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
                                  : xMode
                                  ? const Color(0xFFE7EFEB)
                                  : paper,
                              borderRadius: BorderRadius.zero,
                              border: border,
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: name != null
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            if (object != null)
                                              Icon(
                                                object.icon,
                                                color: brickDark.withValues(
                                                  alpha: .45,
                                                ),
                                                size: 28,
                                              ),
                                            Text(
                                              name.substring(0, 1),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: ink,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
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
                                                            level
                                                                .suspects
                                                                .length
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
                                                          style:
                                                              const TextStyle(
                                                                color:
                                                                    brickDark,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
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
                                          color: brickDark.withValues(
                                            alpha: .24,
                                          ),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (manualXs.contains(index))
                                  Positioned.fill(
                                    child: IgnorePointer(
                                      child: Center(
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: brickDark.withValues(
                                            alpha: .3,
                                          ),
                                          size: 25,
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
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        roomRow(roomNames.skip(2).toList()),
      ],
    );
  }
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
    required this.xMode,
    required this.onModeChanged,
    required this.selectedMurderer,
    required this.onMurdererChanged,
  });
  final Level level;
  final Map<String, int?> placed;
  final String? activeSuspect;
  final ValueChanged<String> onSuspectTap;
  final bool notesMode;
  final bool xMode;
  final ValueChanged<String> onModeChanged;
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
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(
              value: 'place',
              label: Text('Place person'),
              icon: Icon(Icons.person_add_alt_1_rounded),
            ),
            ButtonSegment(
              value: 'notes',
              label: Text('Add notes'),
              icon: Icon(Icons.edit_note_rounded),
            ),
            ButtonSegment(
              value: 'x',
              label: Text('Mark X'),
              icon: Icon(Icons.close_rounded),
            ),
          ],
          selected: {
            xMode
                ? 'x'
                : notesMode
                ? 'notes'
                : 'place',
          },
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
