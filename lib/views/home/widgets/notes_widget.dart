import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/controllers/home_controller.dart';
import 'package:partner/models/task_model.dart';
import 'package:intl/intl.dart';

class NotesWidget extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  NotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_homeController.tasks.isEmpty) {
        return SizedBox(
          height: 100,
          child: Center(
            child: Text("Không có ghi chú"),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _homeController.tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: _homeController.tasks[index]);
        },
      );
    });
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 110,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF8572FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_today,
                  color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(0.9)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 18, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat.Hm().format(task.datetime),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
