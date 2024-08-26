import 'package:get_it/get_it.dart';
import 'package:spotify_clone/features/auth/data/datasources/auth_firebase_service.dart';
import 'package:spotify_clone/features/auth/domain/usecases/get_favorites.dart';
import 'package:spotify_clone/features/auth/domain/usecases/get_user.dart';
import 'package:spotify_clone/features/songs/data/data_sources/song_firebase_service.dart';
import 'package:spotify_clone/features/auth/data/repository/auth_repository_impl.dart';
import 'package:spotify_clone/features/songs/data/repository/son_repository_impl.dart';
import 'package:spotify_clone/features/auth/domain/repository/auth.dart';
import 'package:spotify_clone/features/songs/domain/repository/song_repository.dart';
import 'package:spotify_clone/features/auth/domain/usecases/signin.dart';
import 'package:spotify_clone/features/auth/domain/usecases/signup.dart';
import 'package:spotify_clone/features/songs/domain/usecases/add_or_remove_favorite.dart';
import 'package:spotify_clone/features/songs/domain/usecases/get_news_songs.dart';
import 'package:spotify_clone/features/songs/domain/usecases/get_playlist.dart';
import 'package:spotify_clone/features/songs/domain/usecases/is_favorite_song.dart';

final sl = GetIt.instance;
Future<void> initilizeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteUseCase>(
      AddOrRemoveFavoriteUseCase());
  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetUserFavoriteSongsUserCase>(GetUserFavoriteSongsUserCase());
}
