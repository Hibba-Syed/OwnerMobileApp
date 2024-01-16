part of 'shared_documents_cubit.dart';

class SharedDocumentsState {
  final SharedDocumentsModel? sharedDocumentsModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final int page;
  const SharedDocumentsState({
    this.sharedDocumentsModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.page = 1,
  });
  SharedDocumentsState copyWith({
    final SharedDocumentsModel? sharedDocumentsModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final int? page,
  }) {
    return SharedDocumentsState(
      sharedDocumentsModel: sharedDocumentsModel ?? this.sharedDocumentsModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      page: page ?? this.page,
    );
  }
}
