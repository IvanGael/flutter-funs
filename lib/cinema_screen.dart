import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class CinemaScreen extends StatefulWidget {
  const CinemaScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CinemaScreenState createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  String selectedCategory = 'Action';

  Map<String, Map<String, dynamic>> data = {
    'Action': {
      'movies': [
        'Die Hard',
        'The Dark Knight',
        'Mad Max: Fury Road',
        'John Wick',
        'Mission: Impossible - Fallout'
      ],
      'desc': {
        '0':
            'Directed by John McTiernan, this classic action film stars Bruce Willis as NYPD officer John McClane. The story unfolds as McClane battles terrorists who have taken hostages in a Los Angeles skyscraper during a Christmas party.',
        '1':
            "Directed by Christopher Nolan, this superhero action film is the second installment in Nolan's Batman trilogy. Christian Bale portrays Batman/Bruce Wayne as he faces off against Heath Ledger's iconic portrayal of the Joker.",
        '2':
            'Directed by George Miller, this post-apocalyptic action film stars Tom Hardy as Max Rockatansky and Charlize Theron as Imperator Furiosa. The movie is known for its intense and relentless vehicular action sequences in a desolate wasteland.',
        '3':
            'Directed by Chad Stahelski, this action thriller stars Keanu Reeves as John Wick, a retired hitman seeking vengeance for the killing of his dog, a gift from his deceased wife. The film is praised for its stylish and well-choreographed action sequences.',
        '4':
            'Directed by Christopher McQuarrie, this installment in the Mission: Impossible franchise stars Tom Cruise as Ethan Hunt. The film features high-stakes spy action, intricate stunts, and a gripping plot involving international espionage.'
      }
    },
    'Drama': {
      'movies': [
        'Moonlight',
        'The Social Network',
        'Forrest Gump',
        "Schindler's List",
        'The Shawshank Redemption'
      ],
      'desc': {
        '0':
            'Directed by Barry Jenkins, this coming-of-age drama is divided into three acts, each depicting a crucial stage in the life of a young African American man named Chiron. The film explores themes of identity, sexuality, and the search for connection.',
        '1':
            "Directed by David Fincher, this drama tells the story of the founding of Facebook and the legal battles that ensued among its co-founders. Jesse Eisenberg portrays Mark Zuckerberg, and the film explores themes of ambition, betrayal, and the consequences of success.",
        '2':
            'Directed by Robert Zemeckis, this film stars Tom Hanks as Forrest Gump, a man with a low IQ but a kind heart who inadvertently influences several defining events in American history. The movie explores themes of love, destiny, and the impact of choices.',
        '3':
            'Directed by Steven Spielberg, this historical drama is based on the true story of Oskar Schindler, a German businessman who saved the lives of more than a thousand Polish Jews during the Holocaust. The film is known for its powerful portrayal of the atrocities of World War II.',
        '4':
            'Directed by Frank Darabont, this film is based on a Stephen King novella and follows the story of Andy Dufresne, played by Tim Robbins, as he navigates life in Shawshank State Penitentiary. The film explores themes of hope, friendship, and the human spirit.'
      }
    },
    'Comedy': {
      'movies': [
        "Ferris Bueller's Day Off",
        'Superbad',
        'Bridesmaids',
        'The Grand Budapest Hotel',
        'Airplane'
      ],
      'desc': {
        '0':
            'Directed by John Hughes, this classic teen comedy follows the charismatic Ferris Bueller, played by Matthew Broderick, as he skips school and embarks on a day of adventure in Chicago with his friends. The film is celebrated for its humor, charm, and memorable moments.',
        '1':
            "Directed by Greg Mottola and produced by Judd Apatow, this coming-of-age comedy follows two high school friends, played by Jonah Hill and Michael Cera, on a quest to have a memorable night before graduation. The film is known for its raunchy humor and genuine depiction of teenage friendships.",
        '2':
            "Directed by Paul Feig, this comedy film follows the lead character, played by Kristen Wiig, as she navigates the challenges of being a maid of honor leading up to her best friend's wedding. The movie is praised for its female-centric humor and relatable situations.",
        '3':
            'Directed by Wes Anderson, this comedy film is known for its distinctive visual style and quirky characters. The story revolves around the misadventures of a hotel concierge, played by Ralph Fiennes, and his protégé. The film combines humor with elements of mystery and drama.',
        '4':
            'Directed by Jim Abrahams, David Zucker, and Jerry Zucker, this spoof comedy film is known for its slapstick humor and parodies of the disaster film genre. The story follows the passengers and crew of an airplane experiencing a crisis, delivering laughs through clever wordplay and visual gags.'
      }
    },
    'Sci-Fi': {
      'movies': [
        'Arrival',
        'Eternal Sunshine of the Spotless Mind',
        'Interstellar',
        'The Matrix',
        'Blade Runner'
      ],
      'desc': {
        '0':
            'Directed by Denis Villeneuve, "Arrival" is a thought-provoking sci-fi film that revolves around linguistics and communication. Amy Adams plays a linguist enlisted to communicate with mysterious extraterrestrial visitors. The film delves into themes of language, time, and the nature of human connection.',
        '1':
            "Directed by Michel Gondry, this sci-fi romantic drama explores the concept of memory erasure. Jim Carrey and Kate Winslet star as a couple who undergo a procedure to erase each other from their memories. The film combines elements of science fiction with a poignant love story.",
        '2':
            'Directed by Christopher Nolan, "Interstellar" is a space epic that follows a team of astronauts, including Matthew McConaughey and Anne Hathaway, as they embark on a journey through a wormhole in search of a new habitable planet for humanity. The film explores themes of time dilation and the survival of the human race.',
        '3':
            'Directed by the Wachowskis, "The Matrix" is a groundbreaking sci-fi film that explores the concept of a simulated reality. Keanu Reeves stars as Neo, a computer hacker who discovers the truth about the world and becomes a central figure in a rebellion against sentient machines.',
        '4':
            "Directed by Ridley Scott, this iconic science fiction film is based on Philip K. Dick's novel Do Androids Dream of Electric Sheep? Set in a dystopian future, it follows Harrison Ford as Rick Deckard, a blade runner tasked with hunting down bioengineered beings known as replicants."
      }
    },
    'Thriller': {
      'movies': [
        'The Silence of the Lambs',
        'Se7en',
        'Gone Girl',
        'The Bourne Identity',
        'Shutter Island'
      ],
      'desc': {
        '0':
            'Directed by Jonathan Demme, this psychological thriller follows FBI trainee Clarice Starling, played by Jodie Foster, as she seeks the help of the brilliant but insane Dr. Hannibal Lecter, portrayed by Anthony Hopkins, to catch a serial killer. The film is known for its intense performances and suspenseful atmosphere.',
        '1':
            "Directed by David Fincher, Se7en is a crime thriller that follows detectives played by Brad Pitt and Morgan Freeman as they investigate a series of gruesome murders based on the seven deadly sins. The film is praised for its dark tone, compelling narrative, and a memorable twist.",
        '2':
            "Directed by David Fincher, this psychological thriller is based on Gillian Flynn's novel. Ben Affleck stars as a man who becomes the prime suspect when his wife, played by Rosamund Pike, goes missing. The film is known for its twists and commentary on media sensationalism.",
        '3':
            'Directed by Doug Liman, this action thriller follows Jason Bourne, played by Matt Damon, as he suffers from amnesia and tries to uncover his true identity while being pursued by assassins and government agents. The film is known for its fast-paced action and espionage elements.',
        '4':
            'Directed by Martin Scorsese, this psychological thriller stars Leonardo DiCaprio as a U.S. Marshal investigating the disappearance of a prisoner from a mental institution on Shutter Island. The film weaves a complex narrative with twists and turns, keeping the audience in suspense.'
      }
    },
  };

  late VideoPlayerController _videoController;
  late CustomVideoPlayerController _customVideoPlayerController;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/opening1.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: _videoController);
    _isPlaying = false;
    _videoController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinema'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/cinema1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Title
                const Text(
                  'Explore the Magic of Cinema',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Featured Movie
                // Container(
                //   height: 200.0,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15.0),
                //     image: const DecorationImage(
                //       image: AssetImage('assets/cinema3.jpg'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   child: const Center(
                //     child: Text(
                //       'Now Showing',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 24.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                if (_videoController.value.isInitialized)
                  SizedBox(
                    width: 400,
                    height: 220,
                    child: CustomVideoPlayer(
                      customVideoPlayerController: _customVideoPlayerController,
                    ),
                  ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _isPlaying = !_isPlaying;
                //       _isPlaying
                //           ? _videoController.play()
                //           : _videoController.pause();
                //     });
                //   },
                //   child: Container(
                //   width: 300,
                //   height: 200,
                //   child: AspectRatio(
                //     aspectRatio: _videoController.value.aspectRatio,
                //     child: VideoPlayer(_videoController),
                //   ),
                //                 ),
                // ),
                const SizedBox(height: 20.0),
                // Movie Categories
                const Text(
                  'Discover by Genre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Horizontal List of Movie Categories
                SizedBox(
                  height: 100.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      MovieCategoryCard(
                        'Action',
                        Icons.explore,
                        selected: selectedCategory == 'Action',
                        onTap: () {
                          _onCategoryTapped('Action');
                        },
                      ),
                      MovieCategoryCard(
                        'Drama',
                        Icons.sentiment_very_satisfied,
                        selected: selectedCategory == 'Drama',
                        onTap: () {
                          _onCategoryTapped('Drama');
                        },
                      ),
                      MovieCategoryCard(
                        'Comedy',
                        Icons.tag_faces,
                        selected: selectedCategory == 'Comedy',
                        onTap: () {
                          _onCategoryTapped('Comedy');
                        },
                      ),
                      MovieCategoryCard(
                        'Sci-Fi',
                        Icons.scatter_plot,
                        selected: selectedCategory == 'Sci-Fi',
                        onTap: () {
                          _onCategoryTapped('Sci-Fi');
                        },
                      ),
                      MovieCategoryCard(
                        'Thriller',
                        Icons.dangerous,
                        selected: selectedCategory == 'Thriller',
                        onTap: () {
                          _onCategoryTapped('Thriller');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                // Movies in Selected Category
                if (selectedCategory.isNotEmpty)
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Movies',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                // List of Movies based on the selected category
                _buildMovieList(selectedCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onCategoryTapped(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Widget _buildMovieList(String selectedCategory) {
    List<String> movies = data[selectedCategory]!['movies'];
    Map<String, String> desc = data[selectedCategory]!['desc'];

    return Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToMovieDescription(
                  context, movies[index], desc[index.toString()]!);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RectangleRoundedCard(movies[index]),
            ),
          );
        },
      ),
    );
  }

  void _navigateToMovieDescription(
      BuildContext context, String movieName, String movieDesc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDescriptionScreen(movieName, movieDesc),
      ),
    );
  }
}

class RectangleRoundedCard extends StatelessWidget {
  final String movieName;

  const RectangleRoundedCard(this.movieName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(
            Icons.movie,
            size: 40.0,
            color: Colors.black,
          ),
          const SizedBox(width: 16.0),
          SizedBox(
            width: 200,
            child: Text(
              movieName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDescriptionScreen extends StatelessWidget {
  final String movieName;
  final String movieDesc;

  const MovieDescriptionScreen(this.movieName, this.movieDesc, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieName),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text(
            movieDesc,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class MovieCategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const MovieCategoryCard(this.category, this.icon,
      {required this.selected, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.0,
        margin: const EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          color: selected
              ? Colors.blue.withOpacity(0.7)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.0,
              color: selected ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 5.0),
            Text(
              category,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
