import 'package:iskaanowner/Models/profile.dart';
import 'package:iskaanowner/Repo/user.dart';

import '../../Utils/utils.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  Future<bool> getProfile(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    return await UserService.getProfile(context).then((value) {
      if (value is Success) {
        emit(state.copyWith(
          profileModel: profileModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
        return true;
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get profile");
      emit(state.copyWith(loadingState: LoadingState.error));
      return false;
    });
  }
}
