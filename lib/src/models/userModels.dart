class User {

  String id_user;
  String name_user;
  String email_user;
  String username;
  String password_user;
  String phone_user;
  String photo_user;
  String status;

  User(this.id_user, this.name_user, this.email_user, this.username,
      this.password_user,
      this.phone_user, this.photo_user, this.status);

  User.fromJason(Map<String, dynamic> json)
    : id_user = json['id_user'],
    name_user = json['name_user'],
    email_user = json['email_user'],
    username = json['username'],
    password_user = json['password_user'],
    phone_user = json['password_user'],
    photo_user = json['photo_user'];

  SetNameUser(String name){
    this.name_user = name;
  }
}

