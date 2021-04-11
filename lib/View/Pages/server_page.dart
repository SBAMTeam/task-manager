import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:taskmanager/Controllers/user_controller.dart';

import 'package:taskmanager/View/Components/CardBuilder.dart';
import 'package:get/get.dart';

import 'package:taskmanager/View/Components/constants.dart';
import 'package:taskmanager/View/Components/text_builder.dart';
import 'package:taskmanager/View/Components/user_info_bar.dart';

class HomePage extends GetView<UserController> {
  const HomePage(this.serverId, {Key key}) : super(key: key);
  final int serverId;
  @override
  Widget build(BuildContext context) {
    var height = Get.height;

    controller.getUsername();
    controller.getNickname();
    taskController.fetchUserServerTasks(serverId);
    int count = Get.height ~/ 120;

    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // height: height / 2.5,
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 12,
                top: 24,
              ),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UserInfoBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: TextBuilder(
                      text: 'My Tasks',
                      maxLines: 1,
                      minFontSize: 12,
                      // fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: height / 4,
                    child: ListView.builder(
                      itemCount: taskController.serverTasksList.length,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String details =
                            (taskController.serverTasksList[index].taskDetails);
                        var detailsShort;
                        if (details.length > 50) {
                          detailsShort = (taskController
                                  .serverTasksList[index].taskDetails)
                              .substring(0,
                                  details.length - (40 - details.length).abs());

                          detailsShort += "...";
                        }
                        DateTime deadlineDate = (taskController
                            .serverTasksList[index].taskDeadline);
                        DateTime startDate = (taskController
                            .serverTasksList[index].taskStartDate);
                        final f = new DateFormat('yyyy-MM-dd hh:mm');

                        return CardBuilder(
                          taskTitle:
                              "${taskController.serverTasksList[index].taskName}",
                          taskDetails:
                              "${details.length > 50 ? detailsShort : details}",
                          taskDeadline: "${f.format(deadlineDate)}",
                          taskStartDate: "${f.format(startDate)}",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height / 2,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(Get.width / 16),
                    margin: EdgeInsets.symmetric(horizontal: Get.width / 16),
                    // height: Get.height / 4.5,
                    // width: Get.width,
                    decoration: BoxDecoration(
                        color: Color(buttonColorTwo),
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(1, 3),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9.0),
                                  child: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    color: Color(buttonColorOne),
                                    child: Icon(
                                      Icons.list,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                AutoSizeText(
                                  "To Do",
                                  // minFontSize: 12,
                                  textScaleFactor: 1.5,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    // fontSize: 24
                                  ),
                                  // fontSize: 25,
                                ),
                              ],
                            ),
                            TextBuilder(
                              text:
                                  "${taskController.serverTasksList.length} tasks",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(9.0), //or 15.0
                                  child: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    color: Color(0xffFF0E58),
                                    child: Icon(
                                      Icons.list,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                AutoSizeText(
                                  "Done",
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Get.width / 3.6,
                            ),
                            TextBuilder(
                              text:
                                  "${taskController.serverTasksDoneList.length} tasks",
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Obx(
      //   () => NavBar(),
      // ),
    );
  }
}
