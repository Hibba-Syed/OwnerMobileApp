part of 'requests_cubit.dart';

class RequestsState {
  final RequestsModel? requestsModel;
  final LoadingState loadingState;
  final String? requestType;
  final String? status;
  final String keyword;
  const RequestsState({
    this.requestsModel,
    this.loadingState = LoadingState.none,
    this.requestType,
    this.status,
    this.keyword = "",
  });
  RequestsState copyWith({
    final RequestsModel? requestsModel,
    final LoadingState? loadingState,
    final String? requestType,
    final String? status,
    final String? keyword,
  }) {
    return RequestsState(
        requestsModel: requestsModel ?? this.requestsModel,
        loadingState: loadingState ?? this.loadingState,
        requestType: requestType ?? this.requestType,
        status: status ?? this.status,
        keyword: keyword ?? this.keyword);
  }

  RequestsState reset({
    final RequestsModel? requestsModel,
    final LoadingState? loadingState,
    final String? requestType,
    final String? status,
    final String? keyword,
  }) {
    return RequestsState(
        requestsModel: requestsModel ?? this.requestsModel,
        loadingState: loadingState ?? this.loadingState,
        status: null,
        requestType: null,
        keyword: keyword ?? this.keyword);
  }
}
