// ignore_for_file: file_names, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/News_Card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  String getNonNullValue(String? value, String defaultValue) {
    return value ?? defaultValue;
  }

  int currentPage = 1;
  int pageSize = 10; // Adjust the page size according to your preferences

  Future<void> fetchNews() async {
    const apiKey = '4ded4f29b2ba4077a9509b8026fdc90a';

    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey&page=$currentPage&pageSize=$pageSize');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(
        () {
          // Decode the JSON response
          Map<String, dynamic> decodedData = json.decode(response.body);

          // Ensure that the decoded data contains a 'articles' key
          if (decodedData.containsKey('articles')) {
            // Access the 'articles' key and append it to newsList
            List<Map<String, dynamic>> newArticles =
                List<Map<String, dynamic>>.from(decodedData['articles']);
            newsList.addAll(newArticles);
            currentPage++; // Increment page for the next request
          } else {
            // Handle the case where the 'articles' key is not present
            print('Invalid data structure: Missing "articles" key');
          }
        },
      );
    } else {
      // Handle errors
      print('Failed to load news');
    }
  }

  Future<void> _refreshNews() async {
    // You can add any additional logic here before refreshing the news
    // For example, resetting the current page to 1
    currentPage = 1;

    await fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshNews,
          child: ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              if (index == newsList.length - 1) {
                // Fetch more news when the user reaches the end of the list
                fetchNews();
              }

              final publishDateTime =
                  DateTime.parse(newsList[index]['publishedAt']);

              return NewsCard(
                title: getNonNullValue(
                    newsList[index]['title'], 'No title available'),
                description: getNonNullValue(
                    newsList[index]['description'], 'No description available'),
                imageUrl: getNonNullValue(newsList[index]['urlToImage'], ''),
                articleUrl: getNonNullValue(newsList[index]['url'], ''),
                author: getNonNullValue(
                    newsList[index]['author'], 'Unknown Author'),
                publishDateTime: publishDateTime,
                // Replace 'tags' with the actual key for tags
              );
            },
          ),
        ),
      ),
    );
  }
}
