import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String receiptId;
  final String formattedTime;
  final String formattedDay;
  final String location;
  final String sender;

  const HeaderSection({
    required this.receiptId,
    required this.formattedTime,
    required this.formattedDay,
    required this.location,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("Số: $receiptId", style: TextStyle(color: Color(0xFF787486), fontSize: 17)),
          SizedBox(height: 10),
          Text("(V/v thu gom, vận chuyển và vận chuyển CTNH)"),
          SizedBox(height: 10),
          Text("Thời gian: $formattedTime, ngày: $formattedDay", style: TextStyle(color: Color(0xFF007AFF), fontSize: 17)),
          SizedBox(height: 10),
          _buildContent("Địa điểm: ", location),
          SizedBox(height: 5),
          _buildContent("Bên giao (Bên A): ", sender),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildContent(String text1, String text2) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: TextStyle(color: Colors.grey, fontSize: 18),
        children: [
          TextSpan(text: text2, style: TextStyle(color: Color(0xFF787486), fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
