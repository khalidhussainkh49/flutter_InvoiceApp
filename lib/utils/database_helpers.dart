import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:invoice_app/models/person_models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'invoice_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE persons(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            building TEXT,
            totalAmount REAL,
            amountPaid REAL,
            address TEXT,
            phoneNumber TEXT
          )
        ''');

        db.execute('''
          CREATE TABLE payments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            personId INTEGER,
            amountPaid REAL,
            paymentDate TEXT
          )
        ''');
      },
    );
  }

  Future<List<Person>> getPersons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('persons');
    return List.generate(maps.length, (i) {
      return Person(
        id: maps[i]['id'],
        name: maps[i]['name'],
        address: maps[i]['address'],
        phoneNumber: maps[i]['phoneNumber'],
        building: maps[i]['building'],
        totalAmount: maps[i]['totalAmount'],
        amountPaid: maps[i]['amountPaid'],
      );
    });
  }

  Future<void> insertPerson(Person person) async {
    final db = await database;
    await db.insert(
      'persons',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePerson(Person person) async {
    final db = await database;
    await db.update(
      'persons',
      person.toMap(),
      where: 'id = ?',
      whereArgs: [person.id],
    );
  }

  Future<List<Payment>> getPaymentsByPersonId(int personId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments',
      where: 'personId = ?',
      whereArgs: [personId],
    );
    return List.generate(maps.length, (i) {
      return Payment(
        id: maps[i]['id'],
        personId: maps[i]['personId'],
        amountPaid: maps[i]['amountPaid'],
        paymentDate: maps[i]['paymentDate'],
      );
    });
  }

  Future<void> insertPayment(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments',
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
