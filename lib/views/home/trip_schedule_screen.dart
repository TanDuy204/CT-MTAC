import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/controllers/home_controller.dart';
import 'package:partner/models/task_model.dart';

class TripScheduleScreen extends StatelessWidget {
  final List<Task> taskList;
  const TripScheduleScreen({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    DateTime currentDay = DateTime.now();
    homeController.filterTasksbyDate(currentDay);
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDay);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Danh sách chuyến",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Xin chào, ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      TextSpan(
                        text: 'Nguyễn Tấn Duy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Lịch thu gom hôm nay:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Spacer(),
                    Text(
                      formattedDate,
                      style: TextStyle(color: Color(0xFF007AFF), fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  homeController.swapItems(oldIndex, newIndex);
                },
                children: List.generate(homeController.tasks.length, (index) {
                  int displayIndex = index + 1;
                  String formattedDate = DateFormat('dd-MM-yyyy')
                      .format(homeController.tasks[index].datetime);
                  return Container(
                    key: ValueKey(index),
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/icon/car_icon.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 8),
                            Text("Chuyến thu gom",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            
                            SizedBox(width: 40),
                            Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                homeController.tasks[index].id,
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            Text("CTG_22223",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        Divider(),
                        _list("Tuyến:", homeController.tasks[index].route),
                        SizedBox(height: 8),
                        _list("Loại hàng:",
                            homeController.tasks[index].cargoType),
                        SizedBox(height: 8),
                        _list("Ngày gom hàng:", formattedDate),
                        SizedBox(height: 8),
                        _list(
                            "Đơn giá:", "${homeController.tasks[index].price}"),
                        SizedBox(height: 30),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(String text1, dynamic text2) {
    String formattedText = text1 == "Đơn giá:"
        ? NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
            .format(text2 is num ? text2 : double.tryParse(text2.toString()))
        : text2.toString();

    return Row(
      children: [
        Text(
          text1,
          style: text1 == "Đơn giá:"
              ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              : TextStyle(fontSize: 16),
        ),
        Spacer(),
        Text(
          formattedText,
          style: text1 == "Đơn giá:"
              ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              : TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
