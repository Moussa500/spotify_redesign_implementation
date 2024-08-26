import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/features/auth/domain/usecases/get_favorites.dart';
import 'package:spotify_clone/features/profile/presentation/block/favorite_songs_state.dart';
import 'package:spotify_clone/features/songs/domain/entities/song/song.dart';
import 'package:spotify_clone/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());
  List<SongEntity> favoriteSongs = [];
  Future<void> getUserFavoriteSongs() async {
    var result = await sl<GetUserFavoriteSongsUserCase>().call();
    result.fold((l) {
      emit(FavoriteSongsFailure());
    }, (r) {
      favoriteSongs = r;
      emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
    });
  }
}
