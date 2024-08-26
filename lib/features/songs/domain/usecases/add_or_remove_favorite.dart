import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/features/songs/domain/repository/song_repository.dart';
import 'package:spotify_clone/service_locator.dart';

class AddOrRemoveFavoriteUseCase extends Usecase<Either,String> {
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
  
}