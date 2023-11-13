import 'package:iskaanowner/Blocs/Happiness%20Center/happiness_center_cubit.dart';
import 'package:iskaanowner/Repo/happiness_center_service.dart';

import '../../Utils/utils.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(const VerifyEmailState());
  Future<void> verifyUser(BuildContext context, int? id, String? email) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await HappinessCenterService.verifyUser(context, id, email).then((value) {
      if (value is Success) {
        context.read<HappinessCenterCubit>().onChangeVerifiedUser(true);
        return emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      context.read<HappinessCenterCubit>().onChangeVerifiedUser(false);
      Fluttertoast.showToast(
        msg: "Unable to verify user",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
