// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget buildErrorContainer() {
  return Container(
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
    child: const Center(
      child: Icon(
        Icons.error,
        color: Colors.blue,
        size: 30,
      ),
    ),
  );
}
