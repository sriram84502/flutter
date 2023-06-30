import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  final accessToken = 'IGQVJYTFdBZAkptMFY4STJIb2FiUnJQcnRVcnpIOXYyTUNUbS1UQ21QVWFubWt4ckZAoOXpqRGdMSW1hbzdjaHdNNjBCYmRRWDRUYm0wRDlzSHh3ZADhjaVFhMExTbWluOC1SN1ZAkZAnZARcG85Ry0tY05iVAZDZD';
  Future<void> retrieveMedia(String accessToken) async {
    final mediaUrl = 'https://graph.instagram.com/me/media'
        '?fields=id,caption&access_token=$accessToken';

    final response = await http.get(Uri.parse(mediaUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mediaList = data['data'];

      for (final media in mediaList) {
        final mediaId = media['id'];
        print(mediaId);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveMedia(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Insta'),
      ),

    );
  }
}
