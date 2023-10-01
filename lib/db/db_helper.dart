import 'dart:io';
import 'package:kas/models/transakasi_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  // inisialisasi variabel yang dibutuhkan
  final String tableName = 'transaksi';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnTanggal = 'tanggal';
  final String columnTotal = 'total';
  final String columnType = 'type';

  DbHelper._internal();
  factory DbHelper() => _instance;
  // cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kas.db');
    await deleteDatabase(path);

    return await openDatabase(path,
        version: 5, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnTanggal TEXT,"
        "$columnTotal INTEGER,"
        "$columnType TEXT,"
        "$columnName TEXT)";
    await db.execute(sql);

    var sql2 = "CREATE TABLE 'password'('id' INTEGER PRIMARY KEY AUTOINCREMENT,"
        "'userPass' TEXT)";
    await db.execute(sql2);
    await db.execute("INSERT INTO 'password'('userPass') VALUES ('user')");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 6) {
      // Tambahkan kolom 'tgl' jika versi sebelumnya adalah 1
      await db.execute("ALTER TABLE $tableName ADD COLUMN $columnTanggal TEXT");
    }
  }

  Future<String?> getPassword() async {
    var dbClient = await _db;
    var result = await dbClient!.query('password', columns: ['userPass']);
    if (result.isNotEmpty) {
      return result.first['userPass'] as String?;
    } else {
      return null;
    }
  }

  // insert ke database
  Future<int?> saveTransaksi(TransaksiModel tm) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, tm.toMap());
  }

  // read database
  Future<List?> getAllTransaksi() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnTanggal,
      columnTotal,
      columnName,
      columnType,
    ]);
    return result.toList();
  }

  Future<double> getIncomeForMonth(String month, String year) async {
    var dbClient = await _db;
    var result = await dbClient!.rawQuery(
      'SELECT SUM($columnTotal) AS sum_income FROM $tableName WHERE $columnType = "Pemasukan" AND substr($columnTanggal, 4, 2) = ? AND substr($columnTanggal, 7, 4) = ?',
      [month.toString(), year.toString()],
    );
    if (result.isNotEmpty) {
      return result.first['sum_income'] != null
          ? double.parse(result.first['sum_income'].toString())
          : 0.0;
    } else {
      return 0.0;
    }
  }

  Future<double> getExpenseForMonth(String month, String year) async {
    var dbClient = await _db;
    var result = await dbClient!.rawQuery(
      'SELECT SUM($columnTotal) AS sum_expense FROM $tableName WHERE $columnType = "Pengeluaran" AND substr($columnTanggal, 4, 2) = ? AND substr($columnTanggal, 7, 4) = ?',
      [month.toString(), year.toString()],
    );
    if (result.isNotEmpty) {
      return result.first['sum_expense'] != null
          ? double.parse(result.first['sum_expense'].toString())
          : 0.0;
    } else {
      return 0.0;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    var dbClient = await _db;
    await dbClient!.update(
      'password',
      {'userPass': newPassword},
      where: 'id = ?',
      whereArgs: [1], // Atur sesuai dengan id yang sesuai dengan password Anda
    );
  }
}