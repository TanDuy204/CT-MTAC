import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/controllers/home_controller.dart';
import 'package:intl/intl.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final startDate = homeController.startDate.value;
            final selectedDate = homeController.selectedDate.value;

            return DatePicker(
              height: 90,
              width: 80,
              startDate,
              locale: "vi_VN",
              daysCount: 7,
              initialSelectedDate: selectedDate,
              selectionColor: const Color(0xFF86BBF4).withOpacity(0.16),
              selectedTextColor: const Color(0xFFDC2626),
              onDateChange: (date) {
                homeController.updateDate(date);
              },
            );
          }),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Chuyến thu gom hôm nay',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Obx(() {
            if (homeController.tasks.isEmpty) {
              return SizedBox(
                height: 100,
                child: Center(child: Text("Không có lịch gom")),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeController.tasks.length,
              itemBuilder: (context, index) {
                final task = homeController.tasks[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 10, bottom: 20),
                  child: Row(
                    children: [
                      // Task time
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
          }),
        ],
      ),
    );
  }
}
