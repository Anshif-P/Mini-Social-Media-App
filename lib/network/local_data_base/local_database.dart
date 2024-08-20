import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        profileImage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE likes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        productId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE saved_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        productId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  // User Authentication Methods

  Future<int?> registerUser(String username, String email, String password,
      String? profileImage) async {
    final db = await database;

    var result =
        await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return null;
    }
    return await db.insert('users', {
      'username': username,
      'email': email,
      'password': password,
      'profileImage': profileImage,
    });
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    var result = await db.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateUserProfileImage(int userId, String profileImage) async {
    final db = await database;
    return await db.update(
      'users',
      {'profileImage': profileImage},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Like Image Method

  Future<int> likeProduct(int userId, int productId) async {
    final db = await database;
    return await db.insert('likes', {'userId': userId, 'productId': productId});
  }

  Future<List<int>> getUserLikedProductIds(int userId) async {
    final db = await database;
    var result = await db.query('likes',
        where: 'userId = ?', whereArgs: [userId], columns: ['productId']);
    return result.map((row) => row['productId'] as int).toList();
  }

  // Save Image Method

  Future<int> saveProduct(int userId, int productId) async {
    final db = await database;
    return await db
        .insert('saved_images', {'userId': userId, 'productId': productId});
  }

  Future<List<int>> getUserSavedProductIds(int userId) async {
    final db = await database;
    var result = await db.query('saved_images',
        where: 'userId = ?', whereArgs: [userId], columns: ['productId']);
    return result.map((row) => row['productId'] as int).toList();
  }

  // Check if product is liked or saved

  Future<bool> isProductLiked(int userId, int productId) async {
    final db = await database;
    var result = await db.query('likes',
        where: 'userId = ? AND productId = ?', whereArgs: [userId, productId]);
    return result.isNotEmpty;
  }

  Future<bool> isProductSaved(int userId, int productId) async {
    final db = await database;
    var result = await db.query('saved_images',
        where: 'userId = ? AND productId = ?', whereArgs: [userId, productId]);
    return result.isNotEmpty;
  }
}
