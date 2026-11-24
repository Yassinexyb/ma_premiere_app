import 'package:flutter/material.dart';

import '../api.dart';
import '../anime_page.dart';

class ListePage extends StatefulWidget {
  const ListePage({super.key});

  @override
  State<ListePage> createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> {
  late final Future<List<Map<String, dynamic>>> futurAnimes;

  @override
  void initState() {
    super.initState();
    futurAnimes = chargerAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animés')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futurAnimes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final animes = snapshot.data!;
          return ListView.builder(
            itemCount: animes.length,
            itemBuilder: (context, index) {
              final anime = animes[index];
              final titre = anime['canonicalTitle'] as String;
              final total = anime['episodeCount'] as int;
              final posterImage = anime['posterImage'];
              final posterUrl = posterImage is Map<String, dynamic>
                  ? posterImage['small']
                  : null;

              return ListTile(
                leading: posterUrl is String
                    ? Image.network(
                        posterUrl,
                        width: 40,
                        height: 56,
                        fit: BoxFit.cover,
                        webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                              width: 40,
                              height: 56,
                              child: Icon(Icons.broken_image_outlined),
                            ),
                      )
                    : const SizedBox(
                        width: 40,
                        height: 56,
                        child: Icon(Icons.image_not_supported_outlined),
                      ),
                title: Text(titre),
                subtitle: Text('$total épisodes'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AnimePage(titre: titre, total: total),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
