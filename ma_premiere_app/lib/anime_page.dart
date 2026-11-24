import 'package:flutter/material.dart';

class AnimePage extends StatefulWidget {
  final String titre;
  final int total;

  const AnimePage({super.key, required this.titre, required this.total});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  int vus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titre)),
      body: Center(
        child: Text(
          'Épisodes vus : $vus / ${widget.total}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            vus++;
            debugPrint('vus = $vus');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
