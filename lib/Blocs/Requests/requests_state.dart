part of 'requests_cubit.dart';

class RequestsState {
  final RequestsModel? requestsModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final String? requestType;
  final String? status;
  final String keyword;
  final int page;
  const RequestsState({
    this.requestsModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.requestType,
    this.status,
    this.keyword = "",
    this.page = 1,
  });
  RequestsState copyWith({
    final RequestsModel? requestsModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final String? requestType,
    final String? status,
    final String? keyword,
    final int? page,
  }) {
    return RequestsState(
      requestsModel: requestsModel ?? this.requestsModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      requestType: requestType ?? this.requestType,
      status: status ?? this.status,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
    );
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
      page: 1,
      keyword: keyword ?? this.keyword,
    );
  }
}
