part of 'request_filters_cubit.dart';

class RequestsFiltersState {
  final RequestsFiltersModel? requestsFiltersModel;
  final LoadingState loadingState;
  const RequestsFiltersState({
    this.requestsFiltersModel,
    this.loadingState = LoadingState.none,
  });
  RequestsFiltersState copyWith({
    final RequestsFiltersModel? requestsFiltersModel,
    final LoadingState? loadingState,
  }) {
    return RequestsFiltersState(
      requestsFiltersModel: requestsFiltersModel ?? this.requestsFiltersModel,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
