import '../../../feature/registration/data/model/users_app.dart';

class AppData {
  UserApp? _userApp;

  UserApp? get getUser => _userApp;

  set setUser(UserApp value) {
    _userApp = value;
  }
}
