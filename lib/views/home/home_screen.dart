import 'package:flutter/material.dart';

import 'package:partner/models/person_model.dart';

import 'package:partner/views/home/widgets/schedule_widget.dart';
import 'package:partner/views/home/widgets/menu_item_widget.dart';
import 'package:partner/views/home/widgets/notes_widget.dart';

class HomeScreen extends StatefulWidget {
  final List<PersonModel> personLists;
  const HomeScreen({super.key, required this.personLists});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào bác tài',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(widget.personLists[0].name),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFF007AFF2).withOpacity(0.16),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Color(0xFF007AFF),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFEF7FF),
          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.personLists[0].licensePlate,
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    widget.personLists[0].msx,
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Text("Tiện ích của bác tài", style: TextStyle(fontSize: 20)),
              SizedBox(height: 15),
              MenuItemWidget(),

              SizedBox(height: 10),

              ///Lịch gom nổi bật
              Text("Lịch gom nổi bật", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              ScheduleWidget(),
              SizedBox(height: 10),

              ///Ghi chú quang trong
              Text("Ghi chú quan trọng", style: TextStyle(fontSize: 20)),
              Text("Đừng quên mình có ghi chú quan trọng nhé bác tài",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 10),
              NotesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
