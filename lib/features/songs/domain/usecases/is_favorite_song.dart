import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/features/songs/domain/repository/song_repository.dart';
import 'package:spotify_clone/service_locator.dart';

class IsFavoriteSongUseCase extends Usecase<bool,String> {
  @override
  Future<bool> call({String ? params}) async{
    return await sl<SongsRepository>().isFavoriteSong(params!);
  } 
}