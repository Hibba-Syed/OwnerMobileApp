import '../../Utils/utils.dart';

part 'happiness_center_state.dart';

class HappinessCenterCubit extends Cubit<HappinessCenterState> {
  HappinessCenterCubit() : super(const HappinessCenterState());
  onChangeRadioValue(String? radioValue) {
    emit(state.copyWith(radioValue: radioValue));
  }

  onChangeEmail(String? email) {
    emit(state.copyWith(email: email));
  }
  onChangeMessage(String? message) {
    emit(state.copyWith(message: message));
  }
  onChangeService(String? service) {
    emit(state.copyWith(service: service));
  }

  onChangeComplaintType(String? complaintType) {
    emit(state.copyWith(complaintType: complaintType));
  }

  onChangeCommunityId(int? communityId) {
    emit(state.copyWith(communityId: communityId));
  }

  onChangeVerifiedUser(bool? verifiedUser) {
    emit(state.copyWith(verifiedUser: verifiedUser));
  }

  onChangeUnitId(int? unitId) {
    emit(state.copyWith(unitId: unitId));
  }
}
