// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

UsermodelNoPassword usermodelNoPasswordFromJson(String str) =>
    UsermodelNoPassword.fromJson(json.decode(str));

String usermodelNoPasswordToJson(UsermodelNoPassword data) =>
    json.encode(data.toJson());

class UsermodelNoPassword {
  UsermodelNoPassword({
    this.logMesseges,
    this.userId,
    this.username,
    this.userEmail,
    this.jwt,
    this.userNickname,
    this.userServers,
    this.userPermissions,
  });

  String logMesseges;
  String userId;
  String username;
  String userEmail;
  String jwt;
  String userNickname;
  List<User> userServers;
  List<User> userPermissions;

  factory UsermodelNoPassword.fromJson(Map<String, dynamic> json) =>
      UsermodelNoPassword(
        logMesseges: json["logMesseges"],
        userId: json["userId"],
        username: json["username"],
        userEmail: json["userEmail"],
        jwt: json["jwt"],
        userNickname: json["userNickname"],
        userServers: json["userServers"] == null
            ? null
            : List<User>.from(json["userServers"].map((x) => User.fromJson(x))),
        userPermissions: json["userPermissions"] == null
            ? null
            : List<User>.from(
                json["userPermissions"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "logMesseges": logMesseges == null ? null : logMesseges,
        "userId": userId == null ? null : userId,
        "username": username == null ? null : username,
        "userEmail": userEmail == null ? null : userEmail,
        "jwt": jwt == null ? null : jwt,
        "userNickname": userNickname == null ? null : userNickname,
        "userServers": userServers == null
            ? null
            : List<dynamic>.from(userServers.map((x) => x.toJson())),
        "userPermissions": userPermissions == null
            ? null
            : List<dynamic>.from(userPermissions.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.serverId,
    this.serverName,
  });

  String serverId;
  String serverName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        serverId: json["Server_id"] == null ? null : json["Server_id"],
        serverName: json["Server_name"] == null ? null : json["Server_name"],
      );

  Map<String, dynamic> toJson() => {
        "Server_id": serverId == null ? null : serverId,
        "Server_name": serverName == null ? null : serverName,
      };
}
