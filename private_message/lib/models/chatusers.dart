class GetChatUsers {
  GetChatUsers({
    required this.image,
    required this.lastSeen,
    required this.name,
    required this.about,
    required this.createdAt,
    required this.phoneNumber,
    required this.id,
    required this.isOnline,
    required this.last,
    required this.pushToken,
  });
  late String image;
  late String lastSeen;
  late String name;
  late String last;
  late String about;
  late String createdAt;
  late String phoneNumber;
  late String id;
  late bool isOnline;
  late String pushToken;

  GetChatUsers.fromJson(Map<String, dynamic> json){
    image = json['image'];
    lastSeen = json['last_seen'];
    name = json['name'];
    about = json['about'];
    createdAt = json['created_at'];
    phoneNumber = json['phone_number'];
    id = json['id'];
    last = json['last'];
    isOnline = json['is_online'];
    pushToken = json['push_token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['last_seen'] = lastSeen;
    data['name'] = name;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['phone_number'] = phoneNumber;
    data['id'] = id;
    data['last'] = last;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    return data;
  }
}