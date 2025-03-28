import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/controllers/waste_controller.dart';
import 'package:partner/delivery/widgets/image_gallery.dart';

class ImagePickerWidget extends StatelessWidget {
  final DeliveryReceiptController controller = Get.find();

  ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFD99D9D94A).withOpacity(0.29),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: controller.addImageFromCamera,
            child: Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.add),
              ),
            ),
          ),
          const SizedBox(width: 50),
          Obx(() {
            return SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                clipBehavior: Clip.none,
                children: List.generate(
                  controller.receiptImages.length,
                  (index) {
                    String imagePath = controller.receiptImages[index];
                    return Positioned(
                      left: index * 5,
                      top: index * 5,
                      child: Transform.rotate(
                        angle: index == 0 ? 0 : (index - 1) * 0.08,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageGallery(
                                      imagePaths: controller.receiptImages,
                                      onDeleteImages: (index) {
                                        controller.deleteImage(index);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 140,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
