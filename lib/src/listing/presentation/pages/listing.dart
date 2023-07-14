import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/core/widgets/app_loader.dart';
import 'package:pet_adoption/src/history/presentation/pages/history_page.dart';
import 'package:pet_adoption/src/listing/data/models/listing_request.dart';
import 'package:pet_adoption/src/listing/presentation/bloc/listing_bloc.dart';
import 'package:pet_adoption/src/listing/presentation/widgets/pet_item_card.dart';
import 'package:pet_adoption/src/settings/settings_view.dart';
import 'package:pet_adoption/src/utils/dimens.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class ListingPage extends StatefulWidget {
  static const routeName = '/listing';

  const ListingPage({Key? key}) : super(key: key);

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  late ListingBloc _listingBloc;
  late ScrollController scrollController;

  late TextEditingController _searchTextController;

  @override
  void dispose() {
    _searchTextController.dispose();
    scrollController.dispose();
    _listingBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    scrollController = ScrollController();
    _searchTextController = TextEditingController();
    _listingBloc = ListingBloc(ListingLoadingState());
    scrollController.addListener(onScroll);
    _listingBloc.add(LoadListingEvent(
      request: ListingRequest(page: 1, pageSize: 10),
    ));
    _searchTextController.addListener(onSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            buildSliverAppBar(context),
          ];
        },
        body: BlocBuilder(
          bloc: _listingBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case ListingLoadingState:
                return const Center(child: AppLoader());
              case ListingLoadCompleteState:
                return buildListView(state as ListingLoadCompleteState);
              case ListingErrorState:
                return Center(
                    child: Text((state as ListingErrorState).error ?? ""));
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  ListView buildListView(ListingLoadCompleteState currentState) {
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
          return PetItemCard(data: currentState.list[index], onAdopted: (){
            _refreshPage(index);
          },);
        }
      },
      scrollDirection: Axis.vertical,
      controller: scrollController,
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: SizedBox(),
      leadingWidth: 0,
      floating: true,
      pinned: false,
      snap: true,
      title: const Text('Petta'),
      actions: [
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            Navigator.of(context).pushNamed(HistoryPage.routeName);
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Navigate to the settings page. If the user leaves and returns
            // to the app after it has been killed while running in the
            // background, the navigation stack is restored.
            Navigator.restorablePushNamed(context, SettingsView.routeName);
          },
        ),
      ],
      bottom: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 6),
          child: Center(
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                  // border: const OutlineInputBorder(),
                  hintText: Strings.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: clearSearch, icon: const Icon(Icons.clear))),
            ),
          ),
        ),
      ),
    );
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll < 300) {
      _listingBloc.add(LoadListingMoreEvent());
    }
  }

  void onSearch() {
    _listingBloc.add((SearchListingEvent(_searchTextController.text)));
  }

  void clearSearch() {
    _searchTextController.clear();
  }

  void _refreshPage(int index) {
    _listingBloc.add(RefreshListingEvent());
  }
}
