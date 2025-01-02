import 'dart:math';

import 'package:betterplayer_demo/models/media.dart';
import 'package:flutter/material.dart';

class MediaRepo {
  Future<List<Media>> getPlaylist() async {
    // Simulating loading
    await Future.delayed(Durations.extralong4);

    if (Random().nextInt(100) == 69) throw "<Insert funny error message here>";

    return const [
      Media(
        "https://byphdgllyk.gpcdn.net/hls/deeptotv/index.m3u8",
        type: MediaType.live,
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2024/11/12/1024857/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2024/04/10/1017325/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2024/04/09/1017316/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2024/02/04/1015579/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2024/01/08/1014886/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2023/12/13/1014279/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2023/09/28/1010091/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2023/04/20/1003279/1/3/1835/manifest.m3u8",
      ),
      Media(
        "https://vhx9nfhlsy.gpcdn.net/transcoded/2023/05/04/1003795/1/3/1835/manifest.m3u8",
      ),
    ];
  }
}
