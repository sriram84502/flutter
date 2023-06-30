import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';

class StartApp extends StatefulWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  Future<FlutterInsta>? instaData;

  @override
  void initState() {
    super.initState();
    instaData = fetchInstaData();
  }

  Future<FlutterInsta> fetchInstaData() async {
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData('virat.kohli');
    return flutterInsta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insta'),
      ),
      body: FutureBuilder<FlutterInsta>(
        future: instaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            FlutterInsta flutterInsta = snapshot.data!;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        if (flutterInsta.imgurl != null)
                          CircleAvatar(
                            backgroundImage: NetworkImage(flutterInsta.imgurl),
                            radius: 45,
                          ),
                        if (flutterInsta.username != null)
                          Text(flutterInsta.username),
                        if (flutterInsta.bio != null) Text(flutterInsta.bio)
                      ],
                    ),
                    Column(
                      children: [
                        Text('Posts'),
                        if (flutterInsta.feedImagesUrl != null)
                          Text(flutterInsta.feedImagesUrl!.length.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Following'),
                        if (flutterInsta.following != null)
                          Text(flutterInsta.following.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Followers'),
                        if (flutterInsta.followers != null)
                          Text(flutterInsta.followers.toString()),
                      ],
                    ),
                  ],
                )
              ],
            );
          }

          // Add a default return statement
          return Container();
        },
      ),
    );
  }
}
