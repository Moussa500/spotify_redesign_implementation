import 'package:dartz/dartz.dart';
import 'package:spotify_clone/features/songs/data/data_sources/song_firebase_service.dart';
import 'package:spotify_clone/features/songs/domain/repository/song_repository.dart';
import 'package:spotify_clone/service_locator.dart';

class SongRepositoryImpl extends SongsRepository{

  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async{
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId)async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}