import 'package:iskaanowner/Models/shared_document.dart';

import '../../Utils/utils.dart';

part 'shared_documents_state.dart';

class SharedDocumentsCubit extends Cubit<SharedDocumentsState> {
  SharedDocumentsCubit() : super(const SharedDocumentsState());
  Future<void> getSharedDocuments(BuildContext context, {int? unitId}) async {
   
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await CommunitiesService.getSharedDocuments(context, unitId, state.page)
        .then((value) {
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
              "Unable to get shared documents");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getMoreSharedDocuments(BuildContext context,
      {int? unitId}) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await CommunitiesService.getSharedDocuments(context, unitId, state.page)
        .then((value) {
      if (value is Success) {
        if (sharedDocumentsModelFromJson(value.response as String)
                .sharedDocuments
                ?.isNotEmpty ??
            false) {
          state.sharedDocumentsModel?.sharedDocuments?.addAll(
              sharedDocumentsModelFromJson(value.response as String)
                      .sharedDocuments ??
                  []);
          return emit(state.copyWith(
            sharedDocumentsModel: state.sharedDocumentsModel,
            loadMoreState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get documents");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }
}
