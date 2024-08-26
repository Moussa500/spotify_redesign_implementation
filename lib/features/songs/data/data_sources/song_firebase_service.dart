import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/features/songs/data/models/song_model.dart';
import 'package:spotify_clone/features/songs/domain/entities/song/song.dart';
import 'package:spotify_clone/features/songs/domain/usecases/is_favorite_song.dart';
import 'package:spotify_clone/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  final _firebseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await _firebseFirestore
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      for (var element in data.docs) {
        print("data : ${data.docs}");
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        print('songModel:${songModel.artist}');
        songs.add(
          songModel.toEntity(),
        );
      }
      return Right(songs);
    } on FirebaseException catch (e) {
      return Left(e.toString);
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await _firebseFirestore
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(
          songModel.toEntity(),
        );
      }
      return Right(songs);
    } on FirebaseException catch (e) {
      return Left(e.toString);
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    try {
      late bool isFavorite;
      var user = await _auth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs = await _firebseFirestore
          .collection('users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        _firebseFirestore
            .collection('users')
            .doc(uId)
            .collection('favorite')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left('An error occured');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      var user = await _auth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs = await _firebseFirestore
          .collection('users')
          .doc(uId)
          .collection('favorite')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      var user = await _auth.currentUser;
      String uId = user!.uid;
      List<SongEntity> favoriteSongs=[];
      QuerySnapshot favoritesSnapshot=await _firebseFirestore.collection('users').doc(uId).collection('favorite').get();
      for (var element in favoritesSnapshot.docs) {
        String songId=element['songId'];
        var song=await _firebseFirestore.collection('songs').doc(songId).get();
        SongModel songModel=SongModel.fromJson(song.data()!);
        favoriteSongs.add(songModel.toEntity());
      }
      return Right(favoriteSongs);
    } catch (e) {
      return Left('Error Occured');
    }
  }
}
