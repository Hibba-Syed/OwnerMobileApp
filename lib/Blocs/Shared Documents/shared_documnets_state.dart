part of 'shared_documnets_cubit.dart';

class SharedDocumentsState {
  final SharedDocumentsModel? sharedDocumentsModel;
  final LoadingState loadingState;
  const SharedDocumentsState({
    this.sharedDocumentsModel,
    this.loadingState = LoadingState.none,
  });
  SharedDocumentsState copyWith({
    final SharedDocumentsModel? sharedDocumentsModel,
    final LoadingState? loadingState,
  }) {
    return SharedDocumentsState(
      sharedDocumentsModel: sharedDocumentsModel ?? this.sharedDocumentsModel,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
