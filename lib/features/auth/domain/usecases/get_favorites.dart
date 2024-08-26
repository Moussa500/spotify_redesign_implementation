import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/features/auth/data/models/sign_In_req.dart';
import 'package:spotify_clone/features/auth/domain/repository/auth.dart';
import 'package:spotify_clone/features/songs/data/data_sources/song_firebase_service.dart';
import 'package:spotify_clone/service_locator.dart';

class GetUserFavoriteSongsUserCase implements Usecase<Either,dynamic> {
  @override
  Future<Either> call({params})async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}