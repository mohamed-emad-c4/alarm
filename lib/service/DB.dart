import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmDatabase {
  static final AlarmDatabase instance = AlarmDatabase._init();

  static Database? _database;

  AlarmDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('alarms.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE ${AlarmFields.tableName} (
      ${AlarmFields.id} $idType,
      ${AlarmFields.label} $textType,
      ${AlarmFields.time} $textType,
      ${AlarmFields.days} $textType,
      ${AlarmFields.isActive} $boolType,
      ${AlarmFields.sound} $textType,
      ${AlarmFields.repeat} $boolType,
      ${AlarmFields.vibration} $boolType,
      ${AlarmFields.snooze} $intType
    )
    ''');
  }

  Future<AlarmModel> create(AlarmModel alarm) async {
    final db = await instance.database;

    final id = await db.insert(AlarmFields.tableName, alarm.toJson());
    return alarm.copyWith(id: id);
  }

  Future<AlarmModel> readAlarm(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      AlarmFields.tableName,
      columns: AlarmFields.values,
      where: '${AlarmFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AlarmModel.fromJson(maps.first);
    } else {
      throw Exception('Alarm ID $id not found');
    }
  }

  Future<List<AlarmModel>> readAllAlarms() async {
    final db = await instance.database;

    final result = await db.query(
      AlarmFields.tableName,
      orderBy: '${AlarmFields.time} ASC',
    );

    return result.map((json) => AlarmModel.fromJson(json)).toList();
  }

  Future<int> update(AlarmModel alarm) async {
    final db = await instance.database;

    return db.update(
      AlarmFields.tableName,
      alarm.toJson(),
      where: '${AlarmFields.id} = ?',
      whereArgs: [alarm.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      AlarmFields.tableName,
      where: '${AlarmFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllAlarms() async {
    final db = await instance.database;

    await db.delete(AlarmFields.tableName);
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
}

class AlarmModel {
  final int? id;
  final String label;
  final String time; // Use a formatted time string
  final String days; // Store as a comma-separated string of days (e.g., "Mon,Tue,Wed")
  final bool isActive;
  final String sound;
  final bool repeat;
  final bool vibration;
  final int snooze; // Store snooze duration in minutes

  AlarmModel({
    this.id,
    required this.label,
    required this.time,
    required this.days,
    this.isActive = true,
    required this.sound,
    this.repeat = false,
    this.vibration = true,
    this.snooze = 5,
  });

  Map<String, dynamic> toJson() => {
        AlarmFields.id: id,
        AlarmFields.label: label,
        AlarmFields.time: time,
        AlarmFields.days: days,
        AlarmFields.isActive: isActive ? 1 : 0,
        AlarmFields.sound: sound,
        AlarmFields.repeat: repeat ? 1 : 0,
        AlarmFields.vibration: vibration ? 1 : 0,
        AlarmFields.snooze: snooze,
      };

  static AlarmModel fromJson(Map<String, dynamic> json) => AlarmModel(
        id: json[AlarmFields.id] as int?,
        label: json[AlarmFields.label] as String,
        time: json[AlarmFields.time] as String,
        days: json[AlarmFields.days] as String,
        isActive: json[AlarmFields.isActive] == 1,
        sound: json[AlarmFields.sound] as String,
        repeat: json[AlarmFields.repeat] == 1,
        vibration: json[AlarmFields.vibration] == 1,
        snooze: json[AlarmFields.snooze] as int,
      );

  AlarmModel copyWith({
    int? id,
    String? label,
    String? time,
    String? days,
    bool? isActive,
    String? sound,
    bool? repeat,
    bool? vibration,
    int? snooze,
  }) =>
      AlarmModel(
        id: id ?? this.id,
        label: label ?? this.label,
        time: time ?? this.time,
        days: days ?? this.days,
        isActive: isActive ?? this.isActive,
        sound: sound ?? this.sound,
        repeat: repeat ?? this.repeat,
        vibration: vibration ?? this.vibration,
        snooze: snooze ?? this.snooze,
      );
}

class AlarmFields {
  static const String tableName = 'alarms';
  static const String id = '_id';
  static const String label = 'label';
  static const String time = 'time';
  static const String days = 'days';
  static const String isActive = 'is_active';
  static const String sound = 'sound';
  static const String repeat = 'repeat';
  static const String vibration = 'vibration';
  static const String snooze = 'snooze';

  static final List<String> values = [
    id,
    label,
    time,
    days,
    isActive,
    sound,
    repeat,
    vibration,
    snooze,
  ];
}
