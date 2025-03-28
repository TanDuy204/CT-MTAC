import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/mock_data.dart';
import 'package:partner/models/task_model.dart';

class HomeController extends GetxController {
  var tasks = <Task>[].obs;

  void filterTasksbyDate(DateTime selectDate) {
    var formattedDay = DateFormat("yyyy/MM/dd").format(selectDate);

    tasks.value = taskList.where((e) {
      return DateFormat('yyyy/MM/dd').format(e.datetime) == formattedDay;
    }).toList();
  }

  void swapItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    if (oldIndex >= 0 && newIndex >= 0 && oldIndex < tasks.length && newIndex < tasks.length) {
      final Task temp = tasks[oldIndex];
      tasks.removeAt(oldIndex);
      tasks.insert(newIndex, temp);
    }
  }

  void setTasks(List<Task> taskList) {
    tasks.value = taskList;
  }
}
