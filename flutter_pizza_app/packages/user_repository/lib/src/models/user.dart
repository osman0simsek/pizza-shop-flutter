import 'package:user_repository/src/entities/entities.dart';

class MyUser {
  String userId;
  String email;
  //String password;
  String name;
  bool hasActiveCart;

  MyUser({
    required this.userId,
    required this.email,
    //required this.password,
    required this.name,
    required this.hasActiveCart,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    //password: '',
    name: '',
    hasActiveCart: false,
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      //password: password,
      name: name,
      hasActiveCart: hasActiveCart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      //password: entity.password,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
    );
  }

  @override
  String toString() {
    return 'MyUser{userId: $userId, email: $email, name: $name, hasActiveCart: $hasActiveCart}';
  }
}
