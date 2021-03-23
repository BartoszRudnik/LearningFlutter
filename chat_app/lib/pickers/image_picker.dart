import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFunction;

  UserImagePicker({@required this.imagePickFunction});

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future<void> _pickUserImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      this._pickedImage = pickedImageFile;
    });
    this.widget.imagePickFunction(this._pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: _pickedImage != null ? FileImage(this._pickedImage) : null,
          radius: 35,
        ),
        TextButton.icon(
          onPressed: _pickUserImage,
          icon: Icon(Icons.image),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
