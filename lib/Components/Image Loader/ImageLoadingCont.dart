// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget buildLoadingContainer() {
  return const Center(
    child: CircularProgressIndicator(
      strokeWidth: 3.0,
      color: Colors.blue,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    ),
  );
}
