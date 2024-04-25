// job_card.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';

class JobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<dynamic> categories = job['category'] as List<dynamic>;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.network(
              job['himalayasJobs:companyLogo'] ??
                  'https://picsum.photos/250?image=10',
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(job['himalayasJobs:expiryDate'] ?? ''),
                const SizedBox(height: 8),
                (job['minSalary'] != null && job['maxSalary'] != null)
                    ? Text(
                        'Salary: \$${job['minSalary']} - \$${job['maxSalary']}')
                    : const Text('Salary: Not available'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Company: ',
                    ),
                    SizedBox(
                      width: 260,
                      child: Text(
                        '${job['himalayasJobs:companyName'] ?? ''}',
                        style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Wrap(
                //   children: [
                //     if(categories.isNotEmpty)
                //     for(int i=0; i<categories.length; i++)
                //     Chip(
                //       label: Text(categories[i])
                //     )
                //   ],
                // ),
                ElevatedButton(
                  onPressed: () async {
                    // Handle button press, open application link in WebView
                    String applicationLink = job['link'];
                    if (await canLaunchUrl(Uri.parse(applicationLink))) {
                      await launchUrl(Uri.parse(applicationLink));
                    } else {
                      // Handle error, e.g., show a snackbar
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Could not launch application link'),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      elevation: MaterialStateProperty.all<double>(12)),
                  child: const Text(
                    'Apply now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobHiringScreen extends StatefulWidget {
  const JobHiringScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JobListingsState createState() => _JobListingsState();
}

class _JobListingsState extends State<JobHiringScreen> {
  List<Map<String, dynamic>> jobs = [];
  int visibleJobs = 10;
  String searchTerm = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  // Future<void> fetchJobs() async {
  //   setState(() {
  //     loading = true;
  //   });

  //   try {
  //     final response =
  //         await http.get(Uri.parse('https://himalayas.app/jobs/api?limit=150'));
  //         print('status code : ${response.statusCode}');
  //     final data = json.decode(response.body);
  //     setState(() {
  //       jobs = List<Map<String, dynamic>>.from(data['jobs']);
  //       loading = false;
  //     });
  //   } catch (error) {
  //     print('Error fetching job data: $error');
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  Future<void> fetchJobs() async {
    setState(() {
      loading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://himalayas.app/jobs/rss'));
      // print('status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        final xml2Json = Xml2Json();
        xml2Json.parse(response.body);

        final dynamic jsonData = jsonDecode(xml2Json.toParker());
        // print('JSON Data: $jsonData');

        if (jsonData != null &&
            jsonData['rss'] != null &&
            jsonData['rss']['channel'] != null) {
          final items = jsonData['rss']['channel']['item'];
          // print('items Data: $items');

          if (items is List) {
            setState(() {
              jobs = List<Map<String, dynamic>>.from(
                items.map<Map<String, dynamic>>(
                  (item) => item is Map ? item.cast<String, dynamic>() : {},
                ),
              );
              loading = false;
            });
          } else if (items is Map) {
            setState(() {
              jobs = [items.cast<String, dynamic>()];
              loading = false;
            });
          }
        } else {
          // print('Invalid JSON structure');
          setState(() {
            loading = false;
          });
        }
      } else {
        // print('Error fetching job data. Status code: ${response.statusCode}');
        setState(() {
          loading = false;
        });
      }
    } catch (error) {
      // print('Error fetching job data: $error');
      setState(() {
        loading = false;
      });
    }
  }

  void loadMoreJobs() {
    setState(() {
      loading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loading = false;
        visibleJobs += 10;
      });
    });
  }

  List<Map<String, dynamic>> get filteredJobs {
    return jobs
        .where((job) =>
            job['title'].toLowerCase().contains(searchTerm.toLowerCase()) ||
            job['himalayasJobs:companyName']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
        .toList();
  }

  String changeWord(String word) {
    return filteredJobs.length > 1 ? '${word}s' : word;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Himalayas'),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Job title or company name',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const Text('Total : '),
              // const SizedBox(width: 10,),
              Container(
                // padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent, width: 3),
                    shape: BoxShape.circle),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            // border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle),
                        child: Text(
                          '${filteredJobs.length} ${changeWord("job")}',
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              // Text('${changeWord("job")} found'),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          filteredJobs.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                  itemCount: visibleJobs < filteredJobs.length
                      ? visibleJobs + 1
                      : filteredJobs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == visibleJobs && loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (index < filteredJobs.length) {
                      return JobCard(job: filteredJobs[index]);
                    } else {
                      return const SizedBox();
                    }
                  },
                )),
          if (visibleJobs < filteredJobs.length && !loading)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 160, vertical: 16),
              child: ElevatedButton(
                onPressed: loadMoreJobs,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Load More',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    Icon(Icons.autorenew, color: Colors.white)
                  ],
                ),
              ),
            )
        ],
      ),
      //   floatingActionButton: (visibleJobs < filteredJobs.length && !loading) ?
      //   Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16),
      //   child: ElevatedButton(
      //     onPressed: loadMoreJobs,
      //     style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple)
      //     ),
      //     child: const Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           'Load More',
      //           style: TextStyle(
      //             color: Colors.white
      //           ),
      //         ),
      //         Icon(Icons.arrow_downward, color: Colors.white)
      //       ],
      //     ),
      //   ),
      // ) : null,
    );
  }
}
