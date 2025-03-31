import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/mock_data.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 17,
      crossAxisSpacing: 17,
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildMenuItem(
            context,
            Color(0xFF7569DE).withOpacity(0.3),
            Color(0xFF2E1FAF).withOpacity(0.4),
            Icons.calendar_today,
            "Lịch thu gom",
            "Tổng hợp các lịch thu gom của bác tài", () {
          Get.toNamed('/schedule', arguments: taskList,);
        }),
        _buildMenuItem(
            context,
            Color(0XFFB1DE52).withOpacity(0.4),
            Color(0xFFB1DE52).withOpacity(0.35),
            Icons.bar_chart,
            "Thống kê",
            "Thống kê các chỉ số hoạt động của bác tài",
            () {}),
        _buildMenuItem(
            context,
            Color(0xFFD9EADA).withOpacity(0.5),
            Color(0xFFC1DDC3).withOpacity(0.5),
            Icons.help_outline,
            "Hỗ trợ",
            "Hãy liên hệ với chúng tôi khi cần bác tài nhé",
            () {}),
        _buildMenuItem(
            context,
            Color(0xFFF3C41F).withOpacity(0.3),
            Color(0xFFF88C29).withOpacity(0.3),
            Icons.history,
            "Lịch sử",
            "Tổng hợp lịch sử thu gom của bác tài",
            () {}),
      ],
    );
  }
}

Widget _buildMenuItem(BuildContext context, Color color1, Color color2,
    IconData icon, String title, String subTitle, VoidCallback onTap) {
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color1, color2],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: MediaQuery.of(context).size.width < 400 ? 33 : 37, color: Colors.black),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width < 400 ? 17 : 22),
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 400 ? 14 : 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
