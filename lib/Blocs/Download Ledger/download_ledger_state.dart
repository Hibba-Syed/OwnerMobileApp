part of 'download_ledger_cubit.dart';

class DownloadLedgerState {
  final LoadingState loadingState;
  const DownloadLedgerState({
    this.loadingState = LoadingState.none,
  });
  DownloadLedgerState copyWith({final LoadingState? loadingState}) {
    return DownloadLedgerState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
