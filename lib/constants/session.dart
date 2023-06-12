import '../models/user.dart';

class Session {
  static User currentUser = User(
      id: '',
      name: '',
      pwHash: '',
      email: '',
      image:
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
}
