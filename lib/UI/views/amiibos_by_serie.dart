import 'dart:collection';

import 'package:amiidex/UI/widgets/amiibo_actionbar.dart';
import 'package:amiidex/UI/widgets/amiibos.dart';
import 'package:amiidex/UI/widgets/fab.dart';
import 'package:amiidex/UI/widgets/search_bar.dart';
import 'package:amiidex/models/amiibo.dart';
import 'package:amiidex/models/serie.dart';
import 'package:amiidex/util/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:amiidex/providers/amiibo_sort.dart';
import 'package:amiidex/providers/fab_visibility.dart';
import 'package:amiidex/providers/view_as.dart';
import 'package:provider/provider.dart';

class AmiibosBySerieView extends StatefulWidget {
  const AmiibosBySerieView({
    Key key,
    @required this.series,
    @required this.serie,
  }) : super(key: key);

  final UnmodifiableListView<SerieModel> series;
  final SerieModel serie;

  @override
  _AmiibosBySerieViewState createState() => _AmiibosBySerieViewState();
}

class _AmiibosBySerieViewState extends State<AmiibosBySerieView> {
  int _index;
  ScrollController _scrollViewController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _index = widget.series.indexOf(widget.serie);
    _scrollViewController = ScrollController();
    _pageController = PageController(
      initialPage: _index,
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider<AmiiboSortProvider>(
            create: (_) => AmiiboSortProvider(),
          ),
          ChangeNotifierProvider<ViewAsProvider>(
            create: (_) => ViewAsProvider(ItemsDisplayed.amiibo),
          ),
          ChangeNotifierProvider<FABVisibility>(
            create: (_) => FABVisibility(),
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F6),
          body: NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              final FABVisibility fabVisibility = Provider.of<FABVisibility>(
                context,
                listen: false,
              );
              _scrollViewController.addListener(() {
                if (_scrollViewController.position.userScrollDirection ==
                    ScrollDirection.forward) {
                  fabVisibility.visible = true;
                } else {
                  fabVisibility.visible = false;
                }
              });

              final SerieModel serie = widget.series[_index];

              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  title: Semantics(
                    label: I18n.of(context).text('sm-detail-logo'),
                    child: SizedBox(height: kToolbarHeight, child: serie.logo),
                  ),
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: ExcludeSemantics(
                    child: FlexibleSpaceBar(
                      background: serie.header,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: VisibleIconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: VisibleIconButton(
                        icon: Icon(
                          Icons.search,
                          semanticLabel: I18n.of(context).text(
                            'collection-search',
                          ),
                        ),
                        onPressed: () async {
                          await showSearch<AmiiboModel>(
                            context: context,
                            delegate: CustomSearchDelegate(
                              widget.series[_index].amiibos,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                AmiiboActionBar(),
              ];
            },
            body: Container(
              color: Theme.of(context).canvasColor,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.series.length,
                itemBuilder: (BuildContext context, int index) {
                  return AmiibosWidget(
                    amiibos: widget.series[index].amiiboList,
                  );
                },
                onPageChanged: (int index) => setState(() => _index = index),
              ),
            ),
          ),
          floatingActionButton: const FABWdiget(),
        ),
      ),
    );
  }
}

class VisibleIconButton extends StatelessWidget {
  const VisibleIconButton({
    Key key,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).appBarTheme.color ??
            Theme.of(context).primaryColor,
      ),
      alignment: Alignment.center,
      child: RawMaterialButton(
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
