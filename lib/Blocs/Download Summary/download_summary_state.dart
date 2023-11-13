part of 'download_summary_cubit.dart';

class DownloadSummaryState {
  final LoadingState loadingState;
  const DownloadSummaryState({
    this.loadingState = LoadingState.none,
  });
  DownloadSummaryState copyWith({final LoadingState? loadingState}) {
    return DownloadSummaryState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
