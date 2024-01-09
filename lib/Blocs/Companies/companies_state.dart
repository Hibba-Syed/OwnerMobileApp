part of 'companies_cubit.dart';

class CompaniesState {
  final CompaniesModel? companiesModel;
  final LoadingState loadingState;
  const CompaniesState(
      {this.companiesModel, this.loadingState = LoadingState.none});
  CompaniesState copyWith(
      {final CompaniesModel? companiesModel,
      final LoadingState? loadingState}) {
    return CompaniesState(
        companiesModel: companiesModel ?? this.companiesModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
