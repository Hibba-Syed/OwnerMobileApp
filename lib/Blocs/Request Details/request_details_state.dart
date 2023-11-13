part of 'request_details_cubit.dart';

class RequestDetailsState {
  final RequestDetailsModel? requestDetailsModel;
  final LoadingState loadingState;
  const RequestDetailsState({
    this.requestDetailsModel,
    this.loadingState = LoadingState.none,
  });
  RequestDetailsState copyWith({
    final RequestDetailsModel? requestDetailsModel,
    final LoadingState? loadingState,
  }) {
    return RequestDetailsState(
      requestDetailsModel: requestDetailsModel ?? this.requestDetailsModel,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
