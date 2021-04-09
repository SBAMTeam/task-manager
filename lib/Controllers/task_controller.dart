import 'dart:convert';
import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:taskmanager/Database/db_functions.dart';
import 'package:taskmanager/Database/database.dart';
import 'package:taskmanager/Models/fetch_tasks_remporary.dart';
import 'package:taskmanager/Models/server_model.dart';
import 'package:taskmanager/Models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:taskmanager/Models/user_model.dart';
import 'package:taskmanager/View/Components/constants.dart';

class TaskController extends GetxController {
  var isLoading = true.obs;
  // var taskList = List<Task>.empty(growable: true).obs;
  var serverTasksList = List<Task>.empty(growable: true).obs;

  static TaskController _taskController;
  static TaskController getInstance() {
    if (_taskController == null)
      return _taskController = TaskController();
    else
      return _taskController;
  }

  var taskmodel = Taskmodel().obs;

  Future createTask(Taskmodel taskmodel) async {
    final response = await http.post(Uri.parse(createTaskUrl),
        body: jsonEncode(taskmodel.toJson()));
    print(
        "Creating task.. Sent:\n ${taskmodel.toJson()} \n recieved data is.. \n ${response.body} \n with statusCode ${response.statusCode} \n");

    fetchUserServerTasks(int.parse(taskmodel.taskServerId));
    return response.statusCode;
  }

  Future fetchUserServerTasks(int serverId) async {
    FetchTasksModelTemporary a = FetchTasksModelTemporary();
    a.serverId = serverId.toString();
    a.userId = (await DBFunctions.getUserIdInteger()).toString();

    final response =
        await http.post(Uri.parse(fetchTasksUrl), body: jsonEncode(a.toJson()));

    print(
        "Fetching user tasks for server id $serverId.. Sent:\n ${a.toJson()} \n recieved data is.. \n ${response.body} \n with statusCode ${response.statusCode} \n");

    if (response.statusCode == 200) {
      Servermodel servermodel = Servermodel();
      servermodel = servermodelFromJson(response.body);
      servermodel.serverId = serverId.toString();
      try {
        await DBFunctions.insertTasks(servermodel.serverTasks, serverId);
        getServerTasksFromDB(serverId);
      } catch (e) {
        print("exception in fetchUserServerTasks insertTasks $e");
      }
    } else {
      isLoading(false);
    }
    return response.statusCode;
  }

  // Future getUserTasksFromDB() async {
  //   try {
  //     isLoading(true);
  //     var tasks = (await DBFunctions.getUserTasks()).toList();
  //     print("all tasks list length is : ${tasks.length} //task controller");

  //     if (tasks != null || tasks != []) {
  //       taskList.assignAll(tasks);
  //     }
  //   } catch (e) {
  //     print("exception $e in task controller");
  //   } finally {
  //     Future.delayed(
  //       Duration(seconds: 1),
  //       () {
  //         isLoading(false);
  //       },
  //     );
  //   }
  // }
  Future getServerTasksFromDB(int serverId) async {
    try {
      isLoading(true);
      var tasks = (await DBFunctions.getServerTasks(serverId)).toList();
      print("server tasks list length is : ${tasks.length} //task controller");

      if (tasks != null || tasks != []) {
        serverTasksList.assignAll(tasks);
      }
    } catch (e) {
      print("exception $e in task controller");
    } finally {
      Future.delayed(
        Duration(milliseconds: 500),
        () {
          isLoading(false);
        },
      );
    }
  }
}
