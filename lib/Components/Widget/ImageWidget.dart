// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../News_Card.dart';
import '../Image Loader/ImageErrorCont.dart';
import '../Image Loader/ImageLoadingCont.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final NewsCard widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.005, vertical: size.height * 0.01),
      child: Container(
        width: double.infinity,
        height: size.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => buildErrorContainer(),
            placeholder: (context, url) => buildLoadingContainer(),
          ),
        ),
      ),
    );
  }
}
