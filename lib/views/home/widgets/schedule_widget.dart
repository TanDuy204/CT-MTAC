import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/controllers/home_controller.dart';
import 'package:partner/mock_data.dart';
import 'package:intl/intl.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final HomeController _homeController = Get.put(HomeController());
  DateTime selectedDate = DateTime.now();
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = selectedDate.subtract(Duration(days: 2));
    _homeController.filterTasksbyDate(selectedDate);
  }

  void updateDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      startDate = newDate.subtract(Duration(days: 2));
    });
    _homeController.filterTasksbyDate(newDate);
  }

  @override
  Widget build(BuildContext context) {
    taskList.sort((a, b) => a.datetime.compareTo(b.datetime));
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DatePicker(
            height: 90,
            width: 80,
            startDate,
            locale: "vi_VN",
            daysCount: 7,
            initialSelectedDate: selectedDate,
            selectionColor: const Color(0xFF86BBF4).withOpacity(0.16),
            selectedTextColor: const Color(0xFFDC2626),
            onDateChange: (date) {
              updateDate(date);
            },
          ),
          const SizedBox(height: 10),

          //Chuyến thu gom hôm nay
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Chuyến thu gom hôm nay',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Obx(() {
            if (_homeController.tasks.isEmpty) {
              return SizedBox(
                height: 100,
                child: Center(
                  child: Text("Không có lịch gom"),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _homeController.tasks.length,
              itemBuilder: (context, index) {
                final task = _homeController.tasks[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 10, bottom: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          DateFormat.Hm().format(task.datetime),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF007AFF).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            task.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }
}
