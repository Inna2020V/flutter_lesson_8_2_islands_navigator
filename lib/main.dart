// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(const IslandsApp());
}

class Island {
  final String title;
  final String description;
  final String imageUrl;

  Island(this.title, this.description, this.imageUrl);
}

class IslandsApp extends StatefulWidget {
  const IslandsApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IslandsAppState();
}

class _IslandsAppState extends State<IslandsApp> {
  Island? _selectedIsland;

  List<Island> islands = [
    Island(
      'CARIBBEAN',
      'The Caribbean is famous for its festivals',
      'https://174025.selcdn.ru/atlasyco/116/916x490/cd7d911245678c8016c6705c80466b0b4faf77b0.jpg',
    ),
    Island(
        'MALDIVES',
        'The Maldives is one of the best diving destinations in the world',
        'https://files.tpg.ua/pages2/87839/Maldives_main.jpg'),
    Island(
        'SEYCHELLES',
        'The Seychelles is one of the most incredible places on Earth, where you forget about all the troubles, problems and vanity',
        'https://www.votpusk.ru/weather/weather-img/sh-6.jpg'),
    Island(
        'CANARIAS',
        'The Canary Islands are a major tourist destination with over 12 million visitors annually',
        'https://byvali.ru/sites/default/files/pictures/spain/kanarskie-ostrova/tenerife.jpg'),
    Island(
        'BERMUDA',
        'The beaches of Bermuda are endlessly beautiful places, unique in their nature.',
        'https://internationalwealth.info/wp-content/uploads/2016/07/Bermuda-islands.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islands',
      home: Navigator(
        pages: [
          MaterialPage(
            key: const ValueKey('IslandsListPage'),
            child: IslandsListScreen(
              islands: islands,
              onTapped: _handleIslandTapped,
            ),
          ),
          if (_selectedIsland != null)
            IslandDetailsPage(island: _selectedIsland as Island)
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          setState(() {
            _selectedIsland = null;
          });

          return true;
        },
      ),
    );
  }

  void _handleIslandTapped(Island island) {
    setState(() {
      _selectedIsland = island;
    });
  }
}

class IslandDetailsPage extends Page {
  final Island island;

  IslandDetailsPage({
    required this.island,
  }) : super(key: ValueKey(island));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return IslandDetailsScreen(island: island);
      },
    );
  }
}

class IslandsListScreen extends StatelessWidget {
  final List<Island> islands;
  final ValueChanged<Island> onTapped;

  // ignore: use_key_in_widget_constructors
  const IslandsListScreen({
    required this.islands,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Islands',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (var island in islands)
            ListTile(
              contentPadding: const EdgeInsets.all(20),
              title: Text(island.title),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(island.imageUrl),
                backgroundColor: Colors.transparent,
              ),
              onTap: () => onTapped(island),
            )
        ],
      ),
    );
  }
}

class IslandDetailsScreen extends StatelessWidget {
  final Island island;

  // ignore: use_key_in_widget_constructors
  const IslandDetailsScreen({
    required this.island,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          island.title,
          style: const TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: unnecessary_null_comparison
            if (island != null) ...[
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: Text(
              //     island.title,
              //     style: const TextStyle(
              //         fontSize: 30, fontWeight: FontWeight.bold),
              //   ),
              // ),

              Image.network(
                island.imageUrl,
                width: 400,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  island.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
