// ignore_for_file: file_names, avoid_print

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/ImageWidget.dart';
import 'Widget/RoundedButton.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;
  final String author;
  final DateTime publishDateTime;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
    required this.author,
    required this.publishDateTime,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  int likeCount = 0;
  int commentCount = 0;

  String _getFormattedTimeDifference(Duration difference) {
    if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final timeDifference = DateTime.now().difference(widget.publishDateTime);
    final formattedDate =
        DateFormat('dd MMM yyyy, EEEE HH:mm a').format(widget.publishDateTime);

    return Container(
      margin: EdgeInsets.fromLTRB(
          size.width * 0.03, size.height * 0.01, size.width * 0.03, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0, // Set the elevation to 0 to remove Card's default shadow
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Adjust the border radius as needed
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
            horizontal: size.width * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image if imageUrl is not null
              Visibility(
                visible: widget.imageUrl.isNotEmpty,
                child: ImageContainer(size: size, widget: widget),
              ),

              SizedBox(
                height: size.height * 0.01,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.blue,
                      height: 3.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                    ),
                    child: Text(
                      _getFormattedTimeDifference(timeDifference),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.01,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      widget.description,
                      style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'Author: ${widget.author}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Published on: $formattedDate',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              RoundButton(
                size: size,
                widget: widget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
