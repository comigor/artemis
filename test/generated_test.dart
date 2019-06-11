import 'package:test/test.dart';

import 'samples/songs_and_books.dart';

void main() {
  group('On fromJson/toJson', () {
    test('With resolveType, fromJson can infer inherited union type', () async {
      final Query q = Query.fromJson({
        'allResults': [
          {
            '__resolveType': 'Song',
            'id': '1',
            'title': 'My Song',
            'duration': 200,
          },
          {
            '__resolveType': 'Song',
            'id': '2',
            'title': 'Your Song',
            'duration': 230,
          },
          {
            '__resolveType': 'Book',
            'id': '3',
            'title': 'My Book',
            'pages': 109,
          },
          {
            '__resolveType': 'Book',
            'id': '3',
            'title': 'Your Book',
            'pages': 36,
          },
        ]
      });

      expect(q.allResults[0], TypeMatcher<Song>());
      expect(q.allResults[2], TypeMatcher<Book>());
    });

    test('With resolveType, fromJson can infer inherited interface type',
        () async {
      final Query q = Query.fromJson({
        'byIds': [
          {
            '__resolveType': 'Song',
            'id': '1',
            'title': 'My Song',
            'duration': 200,
          },
          {
            '__resolveType': 'Song',
            'id': '2',
            'title': 'Your Song',
            'duration': 230,
          },
          {
            '__resolveType': 'Book',
            'id': '3',
            'title': 'My Book',
            'pages': 109,
          },
          {
            '__resolveType': 'Book',
            'id': '3',
            'title': 'Your Book',
            'pages': 36,
          },
        ]
      });

      expect(q.byIds[0], TypeMatcher<Song>());
      expect(q.byIds[2], TypeMatcher<Book>());
    });
  });
}
