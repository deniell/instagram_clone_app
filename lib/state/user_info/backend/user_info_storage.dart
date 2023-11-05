import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_app/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {


  }
}

