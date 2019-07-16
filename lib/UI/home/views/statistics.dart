import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:amiidex/UI/home/widgets/pie_chart.dart';
import 'package:amiidex/UI/home/widgets/searchbar.dart';
import 'package:amiidex/main.dart';
import 'package:amiidex/models/amiibo_list.dart';
import 'package:amiidex/providers/amiibo_sort.dart';
import 'package:amiidex/providers/fab_visibility.dart';
import 'package:amiidex/providers/owned.dart';
import 'package:amiidex/providers/view_as.dart';
import 'package:amiidex/services/assets.dart';
import 'package:provider/provider.dart';

class StatisticsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FABVisibility fabVisibility = Provider.of<FABVisibility>(context);
    final ScrollController _controller = ScrollController();

    _controller.addListener(
      () => fabVisibility.visible =
          _controller.position.userScrollDirection == ScrollDirection.forward,
    );

    final AssetsService assetsService = locator<AssetsService>();
    final OwnedProvider ownedProvider = Provider.of<OwnedProvider>(context);
    final AmiiboList missedAmiibo =
        AmiiboList.from(assetsService.amiiboLineup.amiibo);
    for (String id in ownedProvider.ownedAmiiboIds) {
      missedAmiibo.remove(assetsService.amiiboLineup.getAmiiboById(id));
    }

    final double ownedCount = ownedProvider.ownedCount.toDouble();
    final double missingCount =
        assetsService.amiiboLineup.amiiboCount.toDouble() - ownedCount;

    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<AmiiboSortProvider>(
          builder: (_) => AmiiboSortProvider(),
        ),
        ChangeNotifierProvider<ViewAsProvider>(
          builder: (_) => ViewAsProvider(ItemsDisplayed.missing),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            final AssetsService assetsService = locator<AssetsService>();

            return <Widget>[
              SearchBar(amiibo: assetsService.amiiboLineup.amiibo),
            ];
          },
          body: OwnedMissingPieChart(
            ownedCount: ownedCount,
            missingCount: missingCount,
          ),
        ),
      ),
    );
  }
}
