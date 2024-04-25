import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CountryGridScreen extends StatefulWidget {
  const CountryGridScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountryGridScreenState createState() => _CountryGridScreenState();
}


class _CountryGridScreenState extends State<CountryGridScreen> {
  List<Country> countries = [];
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final dio = Dio();
    try {
      final response = await dio.get("https://restcountries.com/v3.1/all");

      final List<dynamic> data = response.data;
      List<Country> loadedCountries = data
          .map((countryData) => Country(
                name: countryData['name']['common'],
                flag: countryData['flags']['png'],
              ))
          .toList();

      loadedCountries.sort((a, b) => a.name.compareTo(b.name));

      setState(() {
        countries = loadedCountries;
      });
      setState(() {
        selectedCountry = countries[Random().nextInt(10)];
        selectedCountry!.isSelected = true;
      });
    } catch (error) {
      throw Exception('Failed to load countries');
    }
  }

  void handleCountryTap(Country country) {
    setState(() {
      // Unselect the current country
      if (selectedCountry != null) {
        selectedCountry!.isSelected = false;
      }

      // Select the new country
      if (selectedCountry == country) {
        selectedCountry = null;
      } else {
        selectedCountry = country;
        selectedCountry!.isSelected = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: countries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return GestureDetector(
                    onTap: () => handleCountryTap(country),
                    child: Opacity(
                      opacity: country.isSelected ? 1.0 : 0.7, 
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: country.isSelected
                                        ? Colors.deepPurple
                                        : Colors.black,
                                    width: country.isSelected ? 5 : 1)),
                            child: Card(
                              color: country.isSelected
                                  ? Colors.deepPurple
                                  : Colors.white,
                              child: Image.network(
                                country.flag,
                                height: 60,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            country.name,
                            style: TextStyle(
                              color: country.isSelected
                                  ? Colors.deepPurple
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: country.isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}


class Country {
  final String name;
  final String flag;
  bool isSelected = false;

  Country({required this.name, required this.flag, this.isSelected = false});
}

class Flags {
  final String png;
  final String svg;
  final String alt;

  Flags({required this.png, required this.svg, required this.alt});

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      png: json['png'],
      svg: json['svg'],
      alt: json['alt'],
    );
  }
}
