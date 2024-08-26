import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/features/profile/presentation/block/favorite_songs_cubit.dart';
import 'package:spotify_clone/features/profile/presentation/block/favorite_songs_state.dart';
import 'package:spotify_clone/features/profile/presentation/block/profile_cubit.dart';
import 'package:spotify_clone/features/profile/presentation/block/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        backgroundColor: Color(0xff2C2B2B),
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(height: 30,),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.3,
        decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(state.userEntity.imageUrl!))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(state.userEntity.email!),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  state.userEntity.fullName!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
          if (state is ProfileFailure) {
            return const Text('Please try again');
          }
          return Container();
        }),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getUserFavoriteSongs(),
      child: Column(
        children: [
          const Text('Favorite songs'),
          const SizedBox(height: 20,),
          BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(builder: (context, state) {
            if (state is FavoriteSongsLoading) {
              return const CircularProgressIndicator();
            }
            if (state is FavoriteSongsLoaded) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){

                }, separatorBuilder:(context,index)=>const SizedBox(height: 20,), itemCount: state.favoriteSongs.length);
            }
            if (state is FavoriteSongsFailure) {
              return const Text('Error Occured please try again later');
            }
            return Container();
          })
        ],
      ),
    );
  }
}
