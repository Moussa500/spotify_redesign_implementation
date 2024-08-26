import 'package:spotify_clone/features/auth/domain/entities/user.dart';

abstract class ProfileState{}

class ProfileLoading extends ProfileState{}
class ProfileLoaded extends ProfileState {
  final UserEntity userEntity;
  ProfileLoaded({required this.userEntity});
}
class ProfileFailure extends ProfileState{}