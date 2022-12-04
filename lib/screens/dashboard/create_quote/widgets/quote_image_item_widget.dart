import 'package:admin/domain/models/ui/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuoteImageItemWidget extends StatelessWidget {
  final QuoteImage _image;
  final Function(QuoteImage)? onSelectImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: _image.isSelected ? Border.all(color: Colors.white) : null),
      margin: EdgeInsets.all(6),
      child: ClipRRect(
        child: GestureDetector(
          onTap: () {
            onSelectImage?.call(_image);
          },
          child: CachedNetworkImage(
            imageUrl: _image.url,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) => Icon(
              Icons.image,
              color: Colors.black12,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  const QuoteImageItemWidget({
    this.onSelectImage,
    required QuoteImage image,
  }) : _image = image;
}
