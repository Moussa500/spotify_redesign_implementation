import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/features/songs/domain/usecases/get_news_songs.dart';
import 'package:spotify_clone/features/songs/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_clone/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(SongsLoading());

  Future<void> getNewsSongs() async {
    try {
      var returnedSongs = await sl<GetNewsSongsUseCase>().call();
      returnedSongs.fold((l) {
        emit(NewsSongsLoadFailure());
      }, (r) {
        print('Loaded Songs: $r');
        emit(NewsSongsLoaded(songs: r));
      });
    } catch (e) {
      print('Exception: $e');
      emit(NewsSongsLoadFailure());
    }
  }
}
