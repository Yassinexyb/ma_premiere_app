import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> chargerAnimes() async {
  final url = Uri.https('kitsu.app', '/api/edge/anime', {
    'filter[subtype]': 'TV',
    'filter[status]': 'finished',
    'sort': 'popularityRank',
    'page[limit]': '12',
  });
  final response = await http.get(url);
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw StateError('Kitsu API returned HTTP ${response.statusCode}.');
  }

  final decoded = jsonDecode(response.body);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Kitsu returned an invalid response.');
  }

  final data = decoded['data'];
  if (data is! List) {
    throw const FormatException(
      'Kitsu response does not contain an anime list.',
    );
  }

  return data
      .map<Map<String, dynamic>>((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException('Kitsu returned an invalid anime entry.');
        }

        final attributes = item['attributes'];
        if (attributes is! Map<String, dynamic> ||
            attributes['canonicalTitle'] is! String ||
            attributes['episodeCount'] is! int) {
          throw const FormatException(
            'Kitsu returned invalid anime attributes.',
          );
        }

        return attributes;
      })
      .toList(growable: false);
}
