import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/core/widgets/app_loader.dart';
import 'package:pet_adoption/src/history/data/models/history_request.dart';
import 'package:pet_adoption/src/history/presentation/bloc/history_bloc.dart';
import 'package:pet_adoption/src/history/presentation/widgets/history_item_card.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:pet_adoption/src/utils/dimens.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class HistoryPage extends StatefulWidget {
  static const routeName = '/history';

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryBloc _historyBloc;
  late ScrollController scrollController;

  @override
  void initState() {
    _historyBloc = HistoryBloc(HistoryLoadingState());
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
    _historyBloc.add(LoadHistoryEvent(
      request: HistoryRequest(
          page: Constants.listStartPage, pageSize: Constants.listPageSize),
    ));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _historyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.adoptionHistory),
      ),
      body: BlocBuilder(
        bloc: _historyBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HistoryLoadingState:
              return const Center(child: AppLoader());
            case HistoryLoadCompleteState:
              return buildListView(state as HistoryLoadCompleteState);
            case HistoryEmptyState:
              return Center(
                  child: Column(
                children: [
                  const Text(Strings.adoptionHistoryEmpty),
                  OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(Strings.goBackToHome))
                ],
              ));
            case HistoryErrorState:
              return Center(
                  child: Text((state as HistoryErrorState).error ?? ""));
            default:
              return Container();
          }
        },
      ),
    );
  }

  ListView buildListView(HistoryLoadCompleteState currentState) {
    return ListView.builder(
      itemCount: currentState.list.length + 1,
      itemBuilder: (context, index) {
        if (index == currentState.list.length) {
          if (currentState.canLoadMore) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox(
              height: Dimens.dimen16,
            );
          }
        } else {
          return HistoryItemCard(data: currentState.list[index]);
        }
      },
      scrollDirection: Axis.vertical,
      controller: scrollController,
    );
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll < 300) {
      _historyBloc.add(LoadHistoryMoreEvent());
    }
  }
}
