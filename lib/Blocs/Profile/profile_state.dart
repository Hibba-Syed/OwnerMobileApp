part of 'profile_cubit.dart';

class ProfileState {
  final ProfileModel? profileModel;
  final LoadingState loadingState;
  const ProfileState({
    this.profileModel,
    this.loadingState = LoadingState.none,
  });
  ProfileState copyWith({
    final ProfileModel? profileModel,
    final LoadingState? loadingState,
  }) {
    return ProfileState(
        profileModel: profileModel ?? this.profileModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
