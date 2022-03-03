import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String? initiales;
  final double? radius;

  const CustomImage({Key? key, this.imageUrl, this.initiales, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: radius ?? 0.0,
        backgroundColor: Colors.blue,
        child: Text(initiales ?? "",
            style: TextStyle(color: Colors.white, fontSize: radius)),
      );
    } else {
      ImageProvider provider = CachedNetworkImageProvider(imageUrl!);
      if (radius == null) {
        return InkWell(
          child: Image(
            image: provider,
            width: 250.0,
          ),
          onTap: () {
            _showImage(context, provider);
          },
        );
      } else {
        return InkWell(
          child: CircleAvatar(
            radius: radius,
            backgroundImage: provider,
          ),
          onTap: () {
            _showImage(context, provider);
          },
        );
      }
    }
  }

  Future<void> _showImage(BuildContext context, ImageProvider provider) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext build) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(image: provider),
                ElevatedButton(
                  onPressed: () => Navigator.of(build).pop(),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
