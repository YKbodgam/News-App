// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../News_Card.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final NewsCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.05),
      width: size.width * 0.8,
      child: ElevatedButton(
        onPressed: () async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            // No internet connection, you can display a snackbar or dialog
            // to inform the user.
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No internet connection"),
              ),
            );
          } else {
            // Internet connection is available, call the press function.
            if (widget.articleUrl.isNotEmpty) {
              // Open the article in a web browser
              await launch(widget.articleUrl);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // Adjust the radius as needed
          ),
          // Replace 'primaryColor' with your desired color
        ),
        child: Container(
          height: 25,
          alignment: Alignment.center,
          child: Text(
            'Read More',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
