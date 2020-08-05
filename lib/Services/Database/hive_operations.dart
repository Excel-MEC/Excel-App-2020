import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HiveDB {
  retrieveData({String valueName}) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'hiveDB'));
    Box box = await Hive.openBox("excel");
    var data = box.get(valueName);
    return data;
  }

  storeData({String valueName, var value}) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'hiveDB'));
    Box box = await Hive.openBox("excel");
    await box.put(valueName, value);
  }
}
