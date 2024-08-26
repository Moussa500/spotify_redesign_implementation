import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/features/songs/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  String? songUrl;
  String? coverUrl;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;
  SongModel(
      {required this.isFavorite,
      required this.coverUrl,
      required this.songUrl,
      required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate});
  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
    songUrl = data['songUrl'];
    coverUrl = data['coverUrl'];
    isFavorite = data['isFavorite'];
    songId = data['songId'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        songId: songId!,
        isFavorite: isFavorite!,
        coverUrl: coverUrl!,
        songUrl: songUrl!,
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseDate: releaseDate!);
  }
}
