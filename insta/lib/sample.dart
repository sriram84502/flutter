import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Retrieve user's media
Future<void> retrieveMedia(String accessToken) async {
  final accessToken =
  final mediaUrl = 'https://graph.instagram.com/me/media'
      '?fields=id,caption&access_token=$accessToken';

  final response = await http.get(Uri.parse(mediaUrl));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final mediaList = data['data'];

    for (final media in mediaList) {
      final mediaId = media['id'];

      // Retrieve likes for a specific media item
      await retrieveLikes(accessToken, mediaId);

      // Retrieve comments for a specific media item
      await retrieveComments(accessToken, mediaId);
    }
  } else {
    print('Failed to retrieve media. Status code: ${response.statusCode}');
  }
}

// Retrieve likes for a specific media item
Future<void> retrieveLikes(String accessToken, String mediaId) async {
  final likesUrl = 'https://graph.instagram.com/$mediaId/likes'
      '?access_token=$accessToken';

  final response = await http.get(Uri.parse(likesUrl));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final likes = data['data'];

    // Process retrieved likes
    // ...
  } else {
    print('Failed to retrieve likes. Status code: ${response.statusCode}');
  }
}

// Retrieve comments for a specific media item
Future<void> retrieveComments(String accessToken, String mediaId) async {
  final commentsUrl = 'https://graph.instagram.com/$mediaId/comments'
      '?access_token=$accessToken';

  final response = await http.get(Uri.parse(commentsUrl));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final comments = data['data'];

    // Process retrieved comments
    // ...
  } else {
    print('Failed to retrieve comments. Status code: ${response.statusCode}');
  }
}
class SampleAPITest extends StatefulWidget {
  const SampleAPITest({Key? key}) : super(key: key);

  @override
  State<SampleAPITest> createState() => _SampleAPITestState();
}

class _SampleAPITestState extends State<SampleAPITest> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
