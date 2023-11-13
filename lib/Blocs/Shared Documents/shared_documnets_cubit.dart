import 'package:iskaanowner/Models/shared_document.dart';

import '../../Utils/utils.dart';

part 'shared_documnets_state.dart';

class SharedDocumentsCubit extends Cubit<SharedDocumentsState> {
  SharedDocumentsCubit() : super(const SharedDocumentsState());
  Future<void> getSharedDocuments(BuildContext context, {int? unitId}) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await CommunitiesService.getSharedDocuments(context, unitId).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          sharedDocumentsModel:
              sharedDocumentsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ??
              "Unable to get shared documnets");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
