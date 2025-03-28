import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/models/task_model.dart';

class CollectionScheduleScreen extends StatelessWidget {
  const CollectionScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Task> taskList = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Sắp lịch gom",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFFBBDEFB),
            height: 50,
            child: Row(
              children: [
                Image.asset(
                  "assets/icon/info_icon.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 15),
                Text("Danh sách lịch gom chưa sắp trong ngày")
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(taskList[index].datetime);
                  return Container(
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
                            Spacer(),
                            Text("CTG_22223",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        Divider(),
                        _list("Tuyến:", taskList[index].route, taskList[index]),
                        SizedBox(height: 8),
                        _list("Loại hàng:", taskList[index].cargoType,
                            taskList[index]),
                        SizedBox(height: 8),
                        _list("Ngày gom hàng:", formattedDate, taskList[index]),
                        SizedBox(height: 8),
                        _list("Đơn giá:", "${taskList[index].price}",
                            taskList[index]),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                    color: Color(0xFF79747E),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8), 
                                  ),
                                ),
                                child: Text(
                                  "Chi tiết",
                                  style: TextStyle(color: Color(0xFF79747E)),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                      color: Color(0xFF1565C0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8), 
                                    ),
                                  ),
                                  child: Text(
                                    "Sắp lịch",
                                    style: TextStyle(
                                        color: Color(0xFF1565C0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget _list(String text1, dynamic text2, Task task) {
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
