import 'package:spotify_clone/features/songs/domain/entities/song/song.dart';

abstract class PlayListState {
}
class PlayListLoading extends PlayListState{
}
class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  PlayListLoaded({required this.songs});
}
class PlayListLoadFailure extends PlayListState {
}
