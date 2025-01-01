import 'package:betterplayer_demo/player.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Media? nowPlaying;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Player(media: nowPlaying),
            if (nowPlaying == null)
              const Card.outlined(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Please select a media below to play"),
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 12,
                ),
                itemCount: urls.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final media = urls[index];
                  return ListTile(
                    selected: nowPlaying == media,
                    title: Text(media.url),
                    trailing: _indicators(media),
                    onTap: () => setState(() {
                      nowPlaying = media;
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _indicators(Media media) {
    if (media.type == MediaType.live) {
      return const Chip(
        label: Text("LIVE", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      );
    }

    return null;
  }
}
