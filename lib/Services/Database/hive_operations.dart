import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HiveDB {
  retrieveData({String valueName}) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'hiveDB'));
    Box box = await Hive.openBox(valueName);
    var data = box.get(valueName);
    try {
      box.close();
    } catch (_) {}
    return data;
  }

  storeData({String valueName, var value}) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'hiveDB'));
    Box box = await Hive.openBox(valueName);
    await box.put(valueName, value);
    try {
      box.close();
    } catch (e) {
      print("Writing to DB error: $e");
    }
  }

// Following methods are Used to store the last time event/event-list/Highlights are fetched
// to reduce the number of network calls

// Used to get last time event if fetched (in minutes)
  getTimeStamp(String valueName) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'timeStamps'));
    Box box = await Hive.openBox(valueName);
    DateTime storedDate = box.get(valueName);
    try {
      box.close();
    } catch (_) {}
    if (storedDate == null) return null;
    return DateTime.now().difference(storedDate).inMinutes;
  }

// Used to store last time event is fetched
  setTimeStamp(String valueName) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'timeStamps'));
    Box box = await Hive.openBox(valueName);
    DateTime now = DateTime.now();
    await box.put(valueName, now);
    try {
      box.close();
    } catch (e) {
      print("Writing to DB error: $e");
    }
  }
}
