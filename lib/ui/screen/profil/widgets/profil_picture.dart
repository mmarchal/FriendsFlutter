import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPicture extends StatelessWidget {
  final XFile? imageImporte;
  final String? profileImage;

  const ProfilPicture({Key? key, this.imageImporte, this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Container(
          width: 120,
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: (imageImporte != null)
              ? Image.file(File(imageImporte!.path))
              : (profileImage != null)
                  ? Image.memory(base64Decode(profileImage!))
                  : Image.network('https://picsum.photos/seed/220/600')),
    );
  }
}
