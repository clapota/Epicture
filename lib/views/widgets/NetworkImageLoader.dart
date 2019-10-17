import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String url;

  const NetworkImageLoader(this.url);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes
                      : null,
            ),
          ),
        );
      },
    );
  }
}
