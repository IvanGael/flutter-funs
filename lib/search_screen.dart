import 'package:flutter/material.dart';

class SearchResultData {
  final String airline;
  final String departure;
  final String destination;
  final double price;

  SearchResultData({
    required this.airline,
    required this.departure,
    required this.destination,
    required this.price,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<SearchResultData> searchResults = [
    SearchResultData(
      airline: 'Airline A',
      departure: 'JFK',
      destination: 'LAX',
      price: 300.00,
    ),
    SearchResultData(
      airline: 'Airline B',
      departure: 'ATL',
      destination: 'ORD',
      price: 250.00,
    ),
    SearchResultData(
      airline: 'Airline C',
      departure: 'SFO',
      destination: 'SEA',
      price: 200.00,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16.0),
            _buildFilters(),
            const SizedBox(height: 16.0),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for flights...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFilterChip('Direct'),
        _buildFilterChip('Economy'),
        _buildFilterChip('One-way'),
        _buildFilterChip('Non-stop'),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      onSelected: (bool selected) {
        // Implement filter logic here
      },
      selected: false, // Initial filter state
      selectedColor: Colors.blue.withOpacity(0.3),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return _buildSearchResultCard(searchResults[index]);
        },
      ),
    );
  }

  Widget _buildSearchResultCard(SearchResultData data) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.flight),
        title: Text(data.airline),
        subtitle: Text('${data.departure} - ${data.destination}'),
        trailing: Text('\$${data.price}'),
        onTap: () {
          // Implement action when a search result is tapped
        },
      ),
    );
  }
}
