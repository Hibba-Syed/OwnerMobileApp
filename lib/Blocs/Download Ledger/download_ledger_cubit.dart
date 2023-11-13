import 'package:open_filex/open_filex.dart';

import '../../Repo/document_service.dart';
import '../../Utils/utils.dart';

part 'download_ledger_state.dart';

class DownloadLedgerCubit extends Cubit<DownloadLedgerState> {
  DownloadLedgerCubit() : super(const DownloadLedgerState());
  Future<void> downloadDocument(BuildContext context, String url) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await DocumentService.downloadAndOpenFile(context, url).then((value) {
      if (value is Success) {
        OpenFilex.open(value.response as String);
        Fluttertoast.showToast(msg: "file save to ${value.response}");
        return emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get compliances");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
