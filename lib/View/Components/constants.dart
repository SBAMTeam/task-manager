import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/Controllers/server_controller.dart';
import 'package:taskmanager/Controllers/task_controller.dart';
import 'package:taskmanager/Controllers/user_controller.dart';

var iconColor = 0xffF1F1F1;
var textColor = 0xffF1F1F1;
var textColorSecondary = 0xff6C63FF;
double defaultHeight = 50; //Get.height / 14;
var backgroundColor = 0xff2F2E41;
var textFieldColor = 0xff3F3D56;
var buttonColorOne = 0xff6C63FF;
var buttonColorTwo = 0xff3F3D56;
var sbamColor = 0xffFF6366;
var sizedBoxBigSpace = Get.height / 25;
var sizedBoxSmallSpace = Get.height / 50;
var horizontalPadding = Get.width / 12;
var email = 'Email Address';
var password = 'Password';
var placeholder = 'PLACEHOLDER';
var phone = 'Phone Number';
var statusBarHeight = MediaQuery.of(Get.context).padding.top;
final taskController = Get.find<TaskController>();
final userController = Get.find<UserController>();
final serverController = Get.find<ServerController>();

final baseAPIURL = 'http://3.142.29.182';
final loginUrl = baseAPIURL + '/user/login.php';
final registerUrl = baseAPIURL + '/user/Register.php';
final createServerUrl = baseAPIURL + '/server/create.php';
final joinServerUrl = baseAPIURL + '/server/join.php';
// final selectServerUrl = baseAPIURL + "/server/select.php";
final createTaskUrl = baseAPIURL + "/task/create.php";
final fetchUserServersUrl = baseAPIURL + '/user/fetchServers.php';
final fetchTasksUrl = baseAPIURL + '/server/fetchTasks.php';
final fetchServerMembersUrl = baseAPIURL + '/server/fetchMembers.php';
final fetchUserServerTasksUrl = baseAPIURL + '/user/fetchTasks';
