import 'dart:developer';
import 'dart:io';

import 'package:demo/models/trip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQL {
  SQL._();
  static SQL sql = SQL._();
  late Database databse;

  final String usersTableName = 'users';
  final String userIdColumnName = 'id';
  final String userFirstNameColumnName = 'first_name';
  final String userLastNameColumnName = 'last_name';
  final String userEmailColumnName = 'email';
  final String userPasswordColumnName = 'password';
  final String userPhoneNumberColumnName = 'phoneNumber';
  final String loggedColumnName = 'logged';
  final String tripsTableName = 'trips';
  final String tripIdColumnName = 'id';
  final String tripNameColumnName = 'name';
  final String tripLocationCoulmnName = 'location';
  final String tripDescriptionColumnName = 'description';
  final String tripLikedCountColumnName = 'liked_count';
  final String tripIsLikedColumnName = 'isLiked';
  final String tripUserId = 'user_id';
  final String tripIsBookedMarked = 'isBookedMarked';
  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/${usersTableName}3';
    databse = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $usersTableName (
          idd INTEGER PRIMARY KEY AUTOINCREMENT,
          $userIdColumnName TEXT,
          $userFirstNameColumnName TEXT,
          $userLastNameColumnName TEXT,
          $userEmailColumnName TEXT,
          $userPasswordColumnName TEXT,
          $userPhoneNumberColumnName TEXT,
          $loggedColumnName INTEGER
        )
          
''');
        await db.execute('''
        CREATE TABLE $tripsTableName (
          idd INTEGER PRIMARY KEY AUTOINCREMENT,
          $tripIdColumnName TEXT,
          $tripNameColumnName TEXT,
          $tripLocationCoulmnName TEXT,
          $tripDescriptionColumnName TEXT,
          $tripIsLikedColumnName INTEGER,
          $tripLikedCountColumnName TEXT,
          $tripUserId TEXT,
          $tripIsBookedMarked INTEGER,
          company TEXT,
          url TEXT
        )
''');
        log("db created");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''
        CREATE TABLE $usersTableName (
          idd INTEGER PRIMARY KEY AUTOINCREMENT,
          $userIdColumnName TEXT,
          $userFirstNameColumnName TEXT,
          $userLastNameColumnName TEXT,
          $userEmailColumnName TEXT,
          $userPasswordColumnName TEXT,
          $userPhoneNumberColumnName TEXT,
          $loggedColumnName INTEGER
        )
          
''');
        await db.execute('''
        CREATE TABLE $tripsTableName (
          idd INTEGER PRIMARY KEY AUTOINCREMENT,
          $tripIdColumnName TEXT,
          $tripNameColumnName TEXT,
          $tripLocationCoulmnName TEXT,
          $tripDescriptionColumnName TEXT,
          $tripIsLikedColumnName INTEGER,
          $tripLikedCountColumnName TEXT,
          $tripUserId TEXT,
          $tripIsBookedMarked INTEGER,
          company TEXT,
          url TEXT
        )
''');
        log("db upgraded");
      },
      onOpen: (db) {
        log("db opened");
      },
    );
  }

  Future<List<Map<String,Object?>>> getAllTrips(String id) async {
    return await databse
        .query(tripsTableName, where: 'user_id=?', whereArgs: [id]);
  }

  insert(Trip trip, String id) async {
    List ob = await databse
        .query(tripsTableName, where: "id=?", whereArgs: [trip.id]);
    bool x = false;
    Map<String, dynamic> map = trip.toDBMap();
    map.addAll({'user_id': id});

    if (ob.length == 0) {
      log('insert to database');
      return await databse.insert(tripsTableName, map);
    }
    String d = '';
    for (var element in ob) {
      if (element['user_id'] == id) {
        d = element['id'];
        x = true;
        break;
      }
    }

    if (!x) {
      await databse.insert(tripsTableName, map);
    } else {
      await databse.delete(tripsTableName, where: 'id=?', whereArgs: [d]);
      await databse.insert(tripsTableName, map);
    }
  }
}
