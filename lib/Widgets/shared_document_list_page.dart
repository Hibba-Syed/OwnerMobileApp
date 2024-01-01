import '../Models/shared_document.dart';
import '../Utils/utils.dart';

class SharedDocumentsListPage extends StatefulWidget {
  final int? unitId;
  const SharedDocumentsListPage({super.key, this.unitId});

  @override
  State<SharedDocumentsListPage> createState() =>
      _SharedDocumentsListPageState();
}

class _SharedDocumentsListPageState extends State<SharedDocumentsListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      SharedDocumentsCubit sharedDocumentsCubit =
          context.read<SharedDocumentsCubit>();
      if (sharedDocumentsCubit.state.loadMoreState != LoadingState.loading) {
        sharedDocumentsCubit.getMoreSharedDocuments(context,
            unitId: widget.unitId);
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
    return BlocBuilder<SharedDocumentsCubit, SharedDocumentsState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.sharedDocumentsModel?.sharedDocuments?.isEmpty ?? true) {
          return const CreditNotesPage()
              .emptyList(lottie: "assets/document.json");
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  context.read<SharedDocumentsCubit>().getSharedDocuments(context);
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.sharedDocumentsModel?.sharedDocuments?.length,
                  itemBuilder: (BuildContext context, int index) {
                    SharedDocument? sharedDocumentsRecord =
                        state.sharedDocumentsModel?.sharedDocuments?[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: kGrey.shade300,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: const SharedDocumentPage().sharedDocumentWidget(
                          context, sharedDocumentsRecord, widget.unitId),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 16 / 20),
                ),
              ),
            ),
            if (state.loadMoreState == LoadingState.loading)
              const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}
