import '../Models/requests.dart';
import '../Utils/utils.dart';

class RequestListPage extends StatefulWidget {
  final int? unitId;
  const RequestListPage({super.key, this.unitId});

  @override
  State<RequestListPage> createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      RequestsCubit requestsCubit = context.read<RequestsCubit>();
      if (requestsCubit.state.loadMoreState != LoadingState.loading) {
        requestsCubit.getMoreRequests(context, widget.unitId);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.requestsModel?.applications?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList();
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<RequestsCubit>().getRequests(
                        context,
                        widget.unitId,
                      );
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.requestsModel?.applications?.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Application? application =
                        state.requestsModel?.applications?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<RequestDetailsCubit>()
                                .getRequestDetails(context, application?.id,
                                    application?.applicationType);
                            String? routeName = const RequestsPage()
                                .getRouteName(application?.applicationType);
                            if (routeName != null) {
                              Navigator.pushNamed(context, routeName,
                                  arguments: [
                                    application?.id,
                                    application?.reference,
                                    application?.applicationType,
                                  ]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(
                                      1,
                                      1,
                                    ),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    color: kGrey.shade200),
                              ],
                            ),
                            child: Column(
                              children: [
                                const RequestsPage()
                                    .requestCardHeader(context, application),
                                const SizedBox(
                                  height: 10,
                                ),
                                const RequestsPage()
                                    .requestCardBody(context, application),
                                const SizedBox(
                                  height: 10,
                                ),
                                const RequestsPage()
                                    .requestCardFooter(context, application),
                              ],
                            ),
                          ),
                        ),
                        if ((index + 1) ==
                            state.requestsModel?.applications?.length)
                          const SizedBox(
                            height: 150,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (state.loadMoreState == LoadingState.loading)
              const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}
