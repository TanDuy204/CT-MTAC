import 'package:flutter/material.dart';
import 'dart:io';

class ImageGallery extends StatefulWidget {
  final List<String> imagePaths;
  final Function(int) onDeleteImages;

  const ImageGallery(
      {super.key, required this.imagePaths, required this.onDeleteImages});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Xem ảnh"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                widget.onDeleteImages(_currentPage);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imagePaths.length,
          itemBuilder: (context, index) {
            String imagePath = widget.imagePaths[index];
            return Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            );
          },
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
