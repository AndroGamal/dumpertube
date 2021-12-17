import 'package:shared_preferences/shared_preferences.dart';

class save_data {
  static late SharedPreferences _prefs;
  static late int _i;

  void _ins() async {
    _prefs = await SharedPreferences.getInstance();
    _i = _prefs.getInt("length") ?? 0;
  }

  void save(String value) {
    _i++;
    _prefs.setString("value" + _i.toString(), value);
    _prefs.setInt("length", _i);
    _prefs.commit();
  }

  String read(String key) {
    return _prefs.getString(key) ?? "";
  }

  List<String> read_all() {
    List<String> read_list = [];
    for (int r = 0; r < _i; r++) {
      read_list.add(read("value" + r.toString()));
    }
    return read_list;
  }

  save_data() {
    _ins();
  }
}
