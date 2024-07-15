import 'package:path/path.dart'; // Certifique-se de que esse pacote está adicionado no pubspec.yaml
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'products.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT,
        barcode TEXT,
        quantity INTEGER,
        imagePath TEXT,
        price REAL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE products ADD COLUMN imagePath TEXT');
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE products ADD COLUMN price REAL');
    }
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    try {
      await db.insert('products', product.toJson());
    } catch (e) {
      // Substitua o print por um logger apropriado
      print('Erro ao inserir produto: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    final db = await database;
    try {
      await db.update(
        'products',
        product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      // Substitua o print por um logger apropriado
      print('Erro ao atualizar produto: $e');
    }
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('products');
      return List.generate(maps.length, (i) {
        return Product.fromJson(maps[i]);
      });
    } catch (e) {
      // Substitua o print por um logger apropriado
      print('Erro ao obter produtos: $e');
      return [];
    }
  }

  Future<void> deleteProduct(String id) async {
    final db = await database;
    try {
      await db.delete('products', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      // Substitua o print por um logger apropriado
      print('Erro ao excluir produto: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'name LIKE ? OR barcode LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
      );
      return List.generate(maps.length, (i) {
        return Product.fromJson(maps[i]);
      });
    } catch (e) {
      // Substitua o print por um logger apropriado
      print('Erro ao buscar produtos: $e');
      return [];
    }
  }
}
