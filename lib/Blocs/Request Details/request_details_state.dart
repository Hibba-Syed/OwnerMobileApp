part of 'request_details_cubit.dart';

class RequestDetailsState {
  final AdDetailsModel? adDetailsModel;
  final FoDetailsModel? foDetailsModel;
  final RiDetailsModel? riDetailsModel;
  final WpDetailsModel? wpDetailsModel;
  final SsDetailsModel? ssDetailsModel;
  final CsDetailsModel? csDetailsModel;
  final HbDetailsModel? hbDetailsModel;
  final MoDetailsModel? moDetailsModel;
  final DpDetailsModel? dpDetailsModel;
  final TpDetailsModel? tpDetailsModel;
  final MiDetailsModel? miDetailsModel;
  final LoadingState loadingState;
  const RequestDetailsState({
    this.adDetailsModel,
    this.foDetailsModel,
    this.riDetailsModel,
    this.wpDetailsModel,
    this.ssDetailsModel,
    this.csDetailsModel,
    this.hbDetailsModel,
    this.moDetailsModel,
    this.dpDetailsModel,
    this.tpDetailsModel,
    this.miDetailsModel,
    this.loadingState = LoadingState.none,
  });
  RequestDetailsState copyWith({
    final AdDetailsModel? adDetailsModel,
    final FoDetailsModel? foDetailsModel,
    final RiDetailsModel? riDetailsModel,
    final WpDetailsModel? wpDetailsModel,
    final SsDetailsModel? ssDetailsModel,
    final CsDetailsModel? csDetailsModel,
    final HbDetailsModel? hbDetailsModel,
    final MoDetailsModel? moDetailsModel,
    final DpDetailsModel? dpDetailsModel,
    final TpDetailsModel? tpDetailsModel,
    final MiDetailsModel? miDetailsModel,
    final LoadingState? loadingState,
  }) {
    return RequestDetailsState(
      adDetailsModel: adDetailsModel ?? this.adDetailsModel,
      foDetailsModel: foDetailsModel ?? this.foDetailsModel,
      riDetailsModel: riDetailsModel ?? this.riDetailsModel,
      wpDetailsModel: wpDetailsModel ?? this.wpDetailsModel,
      ssDetailsModel: ssDetailsModel ?? this.ssDetailsModel,
      csDetailsModel: csDetailsModel ?? this.csDetailsModel,
      dpDetailsModel: dpDetailsModel ?? this.dpDetailsModel,
      hbDetailsModel: hbDetailsModel ?? this.hbDetailsModel,
      moDetailsModel: moDetailsModel ?? this.moDetailsModel,
      tpDetailsModel: tpDetailsModel ?? this.tpDetailsModel,
      miDetailsModel: miDetailsModel ?? this.miDetailsModel,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
