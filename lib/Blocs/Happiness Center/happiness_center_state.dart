part of 'happiness_center_cubit.dart';

class HappinessCenterState {
  final int? communityId;
  final String? complaintType;
  final int? unitId;
  final String? email;
  final String? message;
  final String? service;
  final String radioValue;
  final List<File>? fileList;
  final LoadingState loadingState;
  final bool verifiedUser;
  const HappinessCenterState({
    this.communityId,
    this.unitId,
    this.complaintType,
    this.message,
    this.service,
    this.email,
    this.fileList,
    this.verifiedUser = false,
    this.radioValue = "Unit",
    this.loadingState = LoadingState.none,
  });
  HappinessCenterState copyWith({
    final int? communityId,
    final int? unitId,
    final String? complaintType,
    final String? message,
    final String? service,
    final String? email,
    final List<File>? fileList,
    final String? radioValue,
    final LoadingState? loadingState,
    final bool? verifiedUser,
  }) {
    return HappinessCenterState(
      communityId: communityId ?? this.communityId,
      unitId: unitId ?? this.unitId,
      complaintType: complaintType ?? this.complaintType,
      message: message ?? this.message,
      service: service ?? this.service,
      fileList: fileList ?? this.fileList,
      verifiedUser: verifiedUser ?? this.verifiedUser,
      email: email ?? this.email,
      radioValue: radioValue ?? this.radioValue,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
