enum UserType { PARTICULAR, PROFESSIONAL }

class User{

  String name;
  String email;
  String password;
  String phone;
  UserType userType;

  User({
    this.email,
    this.name,
    this.password,
    this.phone,
    this.userType = UserType.PARTICULAR
  });
}