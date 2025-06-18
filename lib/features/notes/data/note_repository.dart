import 'package:aetherium_movil/core/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

part 'note_repository.g.dart';

@riverpod
class NoteRepository extends _$NoteRepository {
  static const _databaseName = 'aetherium.db';
  static const _databaseVersion = 1;
  static const _tableNotes = 'notes';

  Database? _database;

  @override
  NoteRepository build() {
    return this;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentsDirectory.path, _databaseName);
    print('Database path: $dbPath'); // Depuración
    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: (db, version) async {
        print('Creating notes table'); // Depuración
        await db.execute('''
          CREATE TABLE $_tableNotes (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    print('Inserting note: ${note.toJson()}'); // Depuración
    await db.insert(
      _tableNotes,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Note inserted'); // Depuración
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    print('Updating note: ${note.toJson()}'); // Depuración
    await db.update(
      _tableNotes,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    print('Note updated'); // Depuración
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final maps = await db.query(_tableNotes, orderBy: 'createdAt DESC');
    print('Retrieved notes: $maps'); // Depuración
    return maps.map((map) => Note.fromJson(map)).toList();
  }

  Future<Note?> getNoteById(String id) async {
    final db = await database;
    final maps = await db.query(
      _tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Retrieved note by ID $id: $maps'); // Depuración
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    return null;
  }

  Future<void> deleteNote(String id) async {
    final db = await database;
    print('Deleting note with ID: $id'); // Depuración
    await db.delete(
      _tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Note deleted'); // Depuración
  }
}