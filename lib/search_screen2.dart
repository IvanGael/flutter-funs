
import 'package:flutter/material.dart';

class SearchScreen2 extends StatefulWidget {
  const SearchScreen2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen2> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [
    'Flutter',
    'Dart',
    'Mobile Development',
    'OpenAI',
    'GPT-3',
    'Artificial Intelligence',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (query) {
                // Add your search logic here (e.g., filter suggestions based on query)
                setState(() {
                  // For simplicity, I'm filtering suggestions by checking if they contain the query
                  _suggestions = _suggestions
                      .where((suggestion) =>
                          suggestion.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            _suggestions.isEmpty
                ? const Text('No suggestions')
                : Expanded(
                    child: ListView.builder(
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_suggestions[index]),
                          onTap: () {
                            // Handle suggestion tap (e.g., navigate to a new screen)
                            // For now, let's just print the tapped suggestion
                            // print('Tapped: ${_suggestions[index]}');
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}