import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/features/songs/domain/usecases/get_playlist.dart';
import 'package:spotify_clone/features/songs/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_clone/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    try {
      var returnedSongs = await sl<GetPlayListUseCase>().call();
      returnedSongs.fold((l) {
        print('Error: $l'); // Log error
        emit(PlayListLoadFailure());
      }, (r) {
        print('Loaded Songs: $r'); // Log loaded songs
        emit(PlayListLoaded(songs: r));
      });
    } catch (e) {
      print('Exception: $e'); // Log exception
      emit(PlayListLoadFailure());
    }
  }
}
