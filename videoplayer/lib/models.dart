class Userdata {
  Userdata({
    required this.username,
    required this.photo,
    required this.name,
    required this.phone,
    required this.id,
  });
  late final String username;
  late final String photo;
  late final String name;
  late final String phone;
  late final String id;

  Userdata.fromJson(Map<String, dynamic> json){
    username = json['username'];
    photo = json['photo'];
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['photo'] = photo;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['id'] = id;
    return _data;
  }
}