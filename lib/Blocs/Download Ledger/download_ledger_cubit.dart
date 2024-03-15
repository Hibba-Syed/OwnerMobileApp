import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';

import '../../Repo/document_service.dart';
import '../../Utils/utils.dart';

part 'download_ledger_state.dart';

class DownloadLedgerCubit extends Cubit<DownloadLedgerState> {
  DownloadLedgerCubit() : super(const DownloadLedgerState());
  Future<void> downloadDocument(
    BuildContext context,
    String url, {
    String? customFileName,
  }) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await DocumentService.downloadAndOpenFile(
      context,
      url,
      customFileName: customFileName,
    ).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "file save to ${value.response}");
        try {
          OpenFilex.open(value.response as String);
        } catch (e) {
          Fluttertoast.showToast(
              msg:
                  "Make sure you have a program to open files with the extension '${extension(value.response as String).replaceAll(".", "")}'.");
        }
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
