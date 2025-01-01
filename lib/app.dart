import 'package:betterplayer_demo/player.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ValueNotifier<String?> nowPlaying = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ValueListenableBuilder(
              valueListenable: nowPlaying,
              builder: (context, value, placeholder) {
                if (value == null) return placeholder!;
                return Player(url: value);
              },
              child: Text("No video selected"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: urls.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final url = urls[index];
                  return ListTile(
                    title: Text(url),
                    onTap: () => nowPlaying.value = url,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
