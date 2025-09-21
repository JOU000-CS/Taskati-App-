import 'package:hive/hive.dart';
import 'package:taskati/core/models/task_model.dart';


//store object in hive?
//create a model class(Task model)
//amotation class with hivetype and its feild with hivefields
//add build_runner and hive_generator in dev_dependencies
//run command flutter pub run build_runner build
//register adapter in main.dart

class LocalHelper {
  static late Box userBox;
  static late Box<TaskModel> taskbox;
  static String kname = 'name';
  static String kimage = 'image';
  static String kisUploaded = 'isUploaded';
  static String kisDark = 'isDark';


  static init() async {
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    userBox = await Hive.openBox('UserBox');
    taskbox = await Hive.openBox<TaskModel>('TaskBox');
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

  static putTask(String key , TaskModel value)
  {
    taskbox.put(key , value);
  }

  static TaskModel? getTask(String key)
  {
   return taskbox.get(key);
  }

  static changeTheme()
  {
    bool cashedTheme = userBox.get(kisDark) ?? false;
    userBox.put(kisDark, !cashedTheme);
  }
}
