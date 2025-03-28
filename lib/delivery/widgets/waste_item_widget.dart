import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/controllers/waste_controller.dart';

class WasteItemList extends StatelessWidget {
  final int receiptIndex;
  final DeliveryReceiptController controller;
  final Function(int, int) showInputDialog;

  const WasteItemList({
    super.key,
    required this.receiptIndex,
    required this.controller,
    required this.showInputDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// Kiểm tra dữ liệu
      if (controller.deliveryReceipts.isEmpty) {
        return const Center(
            child: Text("Chưa có dữ liệu")); // hoặc CircularProgressIndicator()
      }

      if (receiptIndex >= controller.deliveryReceipts.length) {
        return const Center(child: Text("Dữ liệu không hợp lệ"));
      }

      final wasteItems = controller.deliveryReceipts[receiptIndex].wasteItems;

      if (wasteItems.isEmpty) {
        return const Center(child: Text("Không có chất thải nào"));
      }

      return Column(
        children: List.generate(wasteItems.length, (wasteIndex) {
          final wasteItem = wasteItems[wasteIndex];
          return Container(
            margin: const EdgeInsets.all(5),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(wasteItem.name,
                      style: const TextStyle(color: Colors.grey)),
                ),

                Expanded(
                  flex: 2,
                  child: Text(wasteItem.code,
                      style: const TextStyle(color: Colors.grey)),
                ),

                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30),
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 1)),
                      ],
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: wasteItem.status,
                        alignment: Alignment.center,
                        items: ["R", "L", "B"]
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status,
                                      style:
                                          const TextStyle(color: Colors.green)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateWasteStatus(
                                receiptIndex, wasteIndex, value);
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 30),

                /// Cân nặng
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      showInputDialog(receiptIndex, wasteIndex);
                    },
                    child: Text(
                      "${wasteItem.weight} Kg",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
