import 'package:hive/hive.dart';

class LocalHelper {
  static late Box userBox;
  static String kname = 'name';
  static String kimage = 'image';
  static String kisUploaded = 'isUploaded';

  static init() async {
    userBox = await Hive.openBox('UserBox');
    //userBox = Hive.box('UserBox');
  }

  static putData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getData(String key) {
    return userBox.get(key);
  }

  static putUserData(String name, String image) {
    putData(kname, name);
    putData(kimage, image);
    putData(kisUploaded, true);
  }
}
