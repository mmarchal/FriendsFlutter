import 'package:flutter/material.dart';

class FriendImagePicker {
  void showPicker({
    required BuildContext context,
    required VoidCallback onTapGallery,
    required VoidCallback onTapCamera,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie photos'),
                onTap: () async => onTapGallery,
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Appareil photo'),
                onTap: () async => onTapCamera,
              ),
            ],
          ),
        );
      },
    );
  }
}
