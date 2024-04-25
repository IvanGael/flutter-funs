// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResult {
  final String heading;
  final String abstractSource;
  final String abstractText;
  final String abstractUrl;
  final String answer;
  final String answerType;
  final String definition;
  final String definitionSource;
  final String definitionUrl;
  final String entity;
  final List<Map<String, dynamic>> relatedTopics;
  final List<Map<String, dynamic>> results;
  final String type;
  final Map<String, dynamic> meta;

  SearchResult({
    required this.heading,
    required this.abstractSource,
    required this.abstractText,
    required this.abstractUrl,
    required this.answer,
    required this.answerType,
    required this.definition,
    required this.definitionSource,
    required this.definitionUrl,
    required this.entity,
    required this.relatedTopics,
    required this.results,
    required this.type,
    required this.meta,
  });

  Map<String, dynamic> toJson() {
    return {
      'Heading': heading,
      'AbstractSource': abstractSource,
      'AbstractText': abstractText,
      'AbstractURL': abstractUrl,
      'Answer': answer,
      'AnswerType': answerType,
      'Definition': definition,
      'DefinitionSource': definitionSource,
      'DefinitionURL': definitionUrl,
      'Entity': entity,
      'RelatedTopics': relatedTopics,
      'Results': results,
      'Type': type,
      'meta': meta,
    };
  }

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      heading: json['Heading'] ?? '',
      abstractSource: json['AbstractSource'] ?? '',
      abstractText: json['AbstractText'] ?? '',
      abstractUrl: json['AbstractURL'] ?? '',
      answer: json['Answer'] ?? '',
      answerType: json['AnswerType'] ?? '',
      definition: json['Definition'] ?? '',
      definitionSource: json['DefinitionSource'] ?? '',
      definitionUrl: json['DefinitionURL'] ?? '',
      entity: json['Entity'] ?? '',
      relatedTopics: (json['RelatedTopics'] as List<dynamic>? ?? [])
          .map<Map<String, dynamic>>(
        (topic) {
          if (topic is Map<String, dynamic>) {
            return topic;
          } else if (topic is String) {
            // Handle the case where RelatedTopics is a list of strings
            return {'Text': topic};
          } else {
            return {};
          }
        },
      ).toList(),
      results: (json['Results'] as List<dynamic>? ?? [])
          .map<Map<String, dynamic>>(
              (result) => result is Map<String, dynamic> ? result : {})
          .toList(),
      type: json['Type'] ?? '',
      meta: json['meta'] is Map<String, dynamic>
          ? json['meta'] as Map<String, dynamic>
          : {},
    );
  }
}

class SearchEngineScreen extends StatefulWidget {
  const SearchEngineScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchEngineScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  int totalResults = 0;
  int currentPage = 1;
  int resultsPerPage = 4;
  String isSearching = "";

  Future<void> _search() async {
    final query = _searchController.text;
    setState(() {
      isSearching = "Searching started";
    });
    final response = await http.get(
      Uri.parse('https://api.duckduckgo.com/?q=$query&format=json'),
    );

    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final searchResult = SearchResult.fromJson(data);

      setState(() {
        searchResults = searchResult.relatedTopics.map<Map<String, dynamic>>(
          (topic) {
            // ignore: unnecessary_type_check
            if (topic is Map<String, dynamic>) {
              return topic;
            } else if (topic is String) {
              return {'Text': topic};
            } else {
              return {};
            }
          },
        ).toList();
        totalResults = searchResults.length;
      });
      setState(() {
        isSearching = "Searching success";
      });
    } else {
      // Handle error
      //print('Failed to retrieve search results');
      setState(() {
        isSearching = "Searching failure";
      });
    }
  }

  Widget _buildResultCard(SearchResult result) {
    print('Result: ${result.toJson()}');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: ListTile(
        title: Text(result.heading),
        subtitle:
            result.relatedTopics != null && result.relatedTopics.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: result.relatedTopics
                        .map<Widget>((topic) => Text(topic['Text'] ?? ''))
                        .toList(),
                  )
                : null,
        onTap: () {},
      ),
    );
  }

  Widget _buildPagination() {
    final totalPages = (totalResults / resultsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              currentPage > 1 ? () => _changePage(currentPage - 1) : null,
        ),
        Text('$currentPage/$totalPages'),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: currentPage < totalPages
              ? () => _changePage(currentPage + 1)
              : null,
        ),
      ],
    );
  }

  void _changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                await _search();
              },
            ),
          ),
          onSubmitted: (value) async {
            await _search();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Results',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Results: $totalResults',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            if (isSearching == "")
              const Center(
                child: Text('Search something...'),
              ),
            if (isSearching == "Searching started")
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (isSearching == "Searching success")
              Expanded(
                child: ListView.builder(
                  itemCount: resultsPerPage,
                  itemBuilder: (context, index) {
                    final resultIndex =
                        (currentPage - 1) * resultsPerPage + index;
                    if (resultIndex < searchResults.length) {
                      final searchResult =
                          SearchResult.fromJson(searchResults[resultIndex]);
                      return _buildResultCard(searchResult);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            if (isSearching == "Searching success") _buildPagination(),
          ],
        ),
      ),
    );
  }
}
