import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:partner/controllers/waste_controller.dart';
import 'package:partner/delivery/widgets/delivery_receipt_header.dart';
import 'package:partner/delivery/widgets/receipt_image.dart';
import 'package:partner/delivery/widgets/waste_item_widget.dart';
import 'package:partner/models/delivery_receipt_model.dart';

class DeliveryReceiptScreen extends StatefulWidget {
  final List<DeliveryReceiptModel> deliveryReceipt;

  const DeliveryReceiptScreen({super.key, required this.deliveryReceipt});

  @override
  State<DeliveryReceiptScreen> createState() => _DeliveryReceiptScreenState();
}

class _DeliveryReceiptScreenState extends State<DeliveryReceiptScreen> {
  late final DeliveryReceiptController deliveryReceiptController;
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    deliveryReceiptController = Get.put(DeliveryReceiptController());
  }

  String formatTime(DateTime time) => DateFormat('HH:mm').format(time);
  String formatDay(DateTime time) => DateFormat('dd/MM/yyyy').format(time);

  void showInputDialog(BuildContext context, int receiptIndex, int wasteIndex) {
    final controller = Get.find<DeliveryReceiptController>();
    final wasteItem =
        controller.deliveryReceipts[receiptIndex].wasteItems[wasteIndex];
    final TextEditingController inputController =
        TextEditingController(text: wasteItem.weight.toString());

    Get.defaultDialog(
      title: "Thêm dữ liệu",
      titleStyle: const TextStyle(
          color: Color(0xFF007AFF), fontSize: 20, fontWeight: FontWeight.w500),
      content: Column(
        children: [
          TextField(
            controller: inputController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Nhập khối lượng",
              suffixText: "Kg",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 150,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                final weight = int.tryParse(inputController.text);
                if (weight != null) {
                  controller.updateWeight(receiptIndex, wasteIndex, weight);
                  Get.back();
                } else {
                  Get.snackbar("Lỗi", "Vui lòng nhập số hợp lệ");
                }
              },
              child: const Text(
                "Thêm",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Biên bản giao nhận",
          style: TextStyle(
              color: Color(0xFF0E4A67),
              fontSize: 28,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thông tin chung
            HeaderSection(
              receiptId: widget.deliveryReceipt[0].id,
              formattedTime: formatTime(widget.deliveryReceipt[0].time),
              formattedDay: formatDay(widget.deliveryReceipt[0].time),
              location: widget.deliveryReceipt[0].location,
              sender: widget.deliveryReceipt[0].sender,
            ),
            const SizedBox(height: 10),

            /// Tiêu đề danh sách
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Tên chất thải"),
                Text("Mã CTNH"),
                Text("Trạng thái"),
                Text("Số lượng (kg)"),
              ],
            ),
            const SizedBox(height: 10),

            /// Danh sách chất thải
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.deliveryReceipt.length,
              itemBuilder: (context, receiptIndex) {
                final receipt = widget.deliveryReceipt[receiptIndex];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: WasteItemList(
                    receiptIndex: receiptIndex,
                    controller: deliveryReceiptController,
                    showInputDialog: (receiptIdx, wasteIdx) =>
                        showInputDialog(context, receiptIdx, wasteIdx),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Trạng Thái: R (rắn), L (lỏng), B (bùn)",
                style: TextStyle(color: Color(0xFF787486), fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),

            /// Ảnh biên bản
            const Text(
              "Hình ảnh Biên Bản Giao Nhận",
              style: TextStyle(
                  color: Color(0xFF787486),
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ImagePickerWidget(),
            const SizedBox(height: 20),

            /// Nút gửi biên bản
            Center(
              child: SizedBox(
                width: 300,
                height: 60,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          deliveryReceiptController.isSubmitting.value
                              ? Colors.grey
                              : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.white),
                      ),
                    ),
                    onPressed: deliveryReceiptController.isSubmitting.value
                        ? null
                        : () {
                            final receipt = widget.deliveryReceipt[0];
                            if (deliveryReceiptController
                                .validateReceipt(receipt)) {
                              deliveryReceiptController.submitReceipt(receipt);
                            }
                          },
                    child: deliveryReceiptController.isSubmitting.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Gửi Biên Bản Giao Nhận",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
