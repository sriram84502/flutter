class ChatUser {
  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.id,
    required this.email,
    required this.pushToken,
  });
  late String image;
  late String about;
  late String name;
  late final String createdAt;
  late String lastActive;
  late bool isOnline;
  late final String id;
  late final String email;
  late String pushToken;

  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}