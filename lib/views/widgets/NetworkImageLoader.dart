import 'package:flutter/material.dart';

class NetworkImageLoader extends StatefulWidget {
  final String url;

  const NetworkImageLoader(this.url);

  @override
  _NetworkImageLoaderState createState() => _NetworkImageLoaderState();
}

class _NetworkImageLoaderState extends State<NetworkImageLoader> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Image.network(
      widget.url,
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

  @override
  bool get wantKeepAlive {
    return true;
  }
}
