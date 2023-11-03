import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/provider/city_provider.dart';

class ActivityFormImagePicker extends StatefulWidget {
  final Function? updateUrl;
  const ActivityFormImagePicker({super.key, this.updateUrl});

  @override
  State<ActivityFormImagePicker> createState() =>
      _ActivityFormImagePickerState();
}

class _ActivityFormImagePickerState extends State<ActivityFormImagePicker> {
  final picker = ImagePicker();
  File? _deviceImage;

  Future<void> _pickerImage(ImageSource source) async {
    try {
      XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null && mounted) {
        _deviceImage = File(pickedFile.path);
        final url = await Provider.of<CityProvider>(context, listen: false)
            .uploadImage(_deviceImage);

        widget.updateUrl!(url);
        print('url final $url');
        setState(() {});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Galerie'),
              onPressed: () => _pickerImage(ImageSource.gallery),
            ),
            TextButton.icon(
              icon: const Icon(Icons.photo_camera),
              label: const Text('camera'),
              onPressed: () => _pickerImage(ImageSource.camera),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: _deviceImage != null
              ? Image.file(_deviceImage!)
              : const Text("Aucune image"),
        )
      ],
    );
  }
}
