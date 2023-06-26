
import 'package:data/data.dart';
import 'package:get_storage/get_storage.dart';

class PrefsDataSourceImpl extends PrefsDataSource {

  PrefsDataSourceImpl(this._getStorage);

  final GetStorage _getStorage;

  @override
  bool isDarkMode() {
    return _getStorage.read(Constants.KEY_PREF_IS_DARK_MODE) ?? false;
  }

  @override
  bool setDarkMode(bool isDarkMode) {
    _getStorage.write(Constants.KEY_PREF_IS_DARK_MODE, isDarkMode);

    return isDarkMode;
  }
}
