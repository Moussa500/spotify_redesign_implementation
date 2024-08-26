import 'package:spotify_clone/features/songs/domain/entities/song/song.dart';

abstract class NewsSongsState {
}
class SongsLoading extends NewsSongsState{
}
class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});
}
class NewsSongsLoadFailure extends NewsSongsState {
  
}
