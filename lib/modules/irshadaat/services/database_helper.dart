import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class IrshadateDbHelper {
  // Singleton pattern
  static final IrshadateDbHelper _instance = IrshadateDbHelper._internal();
  factory IrshadateDbHelper() => _instance;
  IrshadateDbHelper._internal();

  static Database? _database;

  // Lazy initialization of database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    // Get the database location on the device
    String path = join(await getDatabasesPath(), 'irshadate.db');

    // Open the database, create it if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create table on database creation
        return db.execute('''
          CREATE TABLE irshadate (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT NOT NULL,
            category TEXT NOT NULL,
            date TEXT NOT NULL
          );
        ''');
      },
    );
  }

  // Insert data into the database
  Future<void> insertData({
    required String content,
    required String category,
    required String date,
  }) async {
    final db = await database;

    // Insert the data into the 'irshadate' table
    await db.insert(
      'irshadate',
      {
        'content': content,
        'category': category,
        'date': date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
    );
  }

  // Get all data from the 'irshadate' table
  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;

    // Query all rows from the 'irshadate' table
    return await db.query('irshadate');
  }

  // Get a specific irshadate entry by ID
  Future<Map<String, dynamic>?> getIrshadateById(int id) async {
    final db = await database;

    // Query the 'irshadate' table for a specific entry by ID
    final List<Map<String, dynamic>> result = await db.query(
      'irshadate',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Return the result (or null if not found)
    return result.isNotEmpty ? result.first : null;
  }

  // Update an existing irshadate entry
  Future<int> updateIrshadate({
    required int id,
    required String content,
    required String category,
    required String date,
  }) async {
    final db = await database;

    // Update the 'irshadate' table with the given data
    return await db.update(
      'irshadate',
      {
        'content': content,
        'category': category,
        'date': date,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete an irshadate entry by ID
  Future<int> deleteIrshadate(int id) async {
    final db = await database;

    // Delete an entry from the 'irshadate' table by ID
    return await db.delete(
      'irshadate',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all irshadate entries
  Future<int> deleteAllIrshadates() async {
    final db = await database;

    // Delete all entries from the 'irshadate' table
    return await db.delete('irshadate');
  }
}
