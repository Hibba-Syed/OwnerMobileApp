import 'package:iskaanowner/Models/owners.dart';

import '../../Utils/utils.dart';

part 'owners_state.dart';

class OwnersCubit extends Cubit<OwnersState> {
  OwnersCubit() : super(const OwnersState());

  Future<void> getOwners(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitOwners(context, id).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          ownersModel: ownersModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get owners");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
