import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  SharedStorage._();

  late SharedPreferences _storage;

  static final SharedStorage instance = SharedStorage._();

  Future<void> initialize() async {
    _storage = await SharedPreferences.getInstance();
  }

  String? get theme => _storage.getString('theme');
  void setTheme(final String theme) => _storage.setString('theme', theme);

  String? get source => _storage.getString('source');
  void setSource(final String source) => _storage.setString('source', source);

  String? get target => _storage.getString('target');
  void setTarget(final String target) => _storage.setString('target', target);

  bool get useInstance => _storage.getBool('useInstance') ?? false;
  void setUseInstance({final bool useInstance = false}) {
    _storage.setBool('useInstance', useInstance);
  }

  String? get instanceUrl => _storage.getString('instanceUrl');
  void setInstanceUrl(final String instanceUrl) => _storage.setString(
        'instanceUrl',
        instanceUrl,
      );
}
