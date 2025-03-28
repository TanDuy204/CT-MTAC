import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/controllers/map_controller.dart';
import 'package:partner/delivery/delivery_receipt_screen.dart';
import 'package:partner/models/delivery_receipt_model.dart';
import 'package:partner/models/destination_model.dart';

class DestinationListWidget extends StatelessWidget {
  final List<DestinationModel> destinations;
  const DestinationListWidget({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    final MapsController destinationController = Get.put(MapsController());
    destinationController.loadDestinations(destinations);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "Theo dõi điểm đến",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: destinationController.destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinationController.destinations[index];
                  final chamColor = destination.isSigned.value
                      ? const Color(0xFF007AFF)
                      : const Color(0xFF656565);
                  final ghiBienBanColor = destination.isSigned.value
                      ? const Color(0xFF656565)
                      : const Color(0xFF925BFE);

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle, size: 10, color: chamColor),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  destination.companyName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text("+BD: ${destination.bd}",
                                    style: const TextStyle(color: Colors.grey)),
                                Text("+CC: ${destination.cc}",
                                    style: const TextStyle(color: Colors.grey)),
                                Text("+GOM: ${destination.gom}",
                                    style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text(destination.note,
                                    style: const TextStyle(color: Colors.grey)),
                                Row(
                                  children: [
                                    Text(
                                      destination.contactName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 170),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.blue),
                                      child: IconButton(
                                        icon: const Icon(Icons.phone,
                                            color: Colors.white),
                                        onPressed: () {
                                          destinationController.callPhoneNumber(
                                              destination.contactPhone);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => InkWell(
                                    onTap: destination.isSigned.value
                                        ? null
                                        : () async {
                                            final result = await Get.to(
                                                () => DeliveryReceiptScreen(
                                                      deliveryReceipt:
                                                          deliveryReceiptList,
                                                    ));

                                            if (result == "done") {
                                              destinationController
                                                  .markAsSigned(index);
                                            }
                                          },
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_note,
                                            color: ghiBienBanColor, size: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Ghi biên bản",
                                          style: TextStyle(
                                            color: ghiBienBanColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
