import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  final Function(File) onImageSelected;

  ImageSourceSheet(this.onImageSelected);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                final File image = File(
                  (await ImagePicker().getImage(source: ImageSource.camera)).path
                );
                onImageSelected(image);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                final File image = File(
                  (await ImagePicker().getImage(source: ImageSource.gallery)).path
                );
                onImageSelected(image);
              },
              child: const Text('Galeria'),
            ),
          ],
        );
      },
    );
  }
}
