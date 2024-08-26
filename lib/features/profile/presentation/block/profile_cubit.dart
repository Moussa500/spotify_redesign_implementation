import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/features/auth/domain/usecases/get_user.dart';
import 'package:spotify_clone/features/profile/presentation/block/profile_state.dart';
import 'package:spotify_clone/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());
  Future<void> getUser() async {
    var user = await sl<GetUserUseCase>().call();
    user.fold((l) {
      emit(ProfileFailure());
    }, (r) {
      emit(ProfileLoaded(userEntity: r));
    });
  }
}
