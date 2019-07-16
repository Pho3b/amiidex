import 'package:flutter/material.dart';
import 'package:amiidex/UI/home/widgets/amiibo_actionbar.dart';
import 'package:amiidex/UI/home/widgets/detail.dart';
import 'package:amiidex/models/amiibo.dart';
import 'package:amiidex/models/amiibo_list.dart';
import 'package:amiidex/providers/series_sort.dart';
import 'package:amiidex/providers/view_as.dart';
import 'package:amiidex/util/i18n.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate<AmiiboModel> {
  CustomSearchDelegate(this.amiibo);

  final AmiiboList amiibo;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <IconButton>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final AmiiboList suggestions = search(context, query, minLength: 1);
    if (suggestions.isEmpty) {
      return Container();
    }
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<SeriesSortProvider>(
          builder: (_) => SeriesSortProvider(),
        ),
        ChangeNotifierProvider<ViewAsProvider>(
          builder: (_) => ViewAsProvider(ItemsDisplayed.searches),
        ),
      ],
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AmiiboActionBar(),
          ];
        },
        body: DetailWidget(amiibo: suggestions),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final AmiiboList suggestions = search(context, query);
    if (suggestions.isEmpty) {
      return Container();
    }
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<SeriesSortProvider>(
          builder: (_) => SeriesSortProvider(),
        ),
        ChangeNotifierProvider<ViewAsProvider>(
          builder: (_) => ViewAsProvider(ItemsDisplayed.searches),
        ),
      ],
      child: DetailWidget(amiibo: suggestions),
    );
  }

  AmiiboList search(BuildContext context, String query, {int minLength = 2}) {
    query = query.trim();
    if (query.length < minLength) {
      return AmiiboList();
    }

    final RegExp regex = _queryToPattern(query);
    if (regex.pattern.isEmpty) {
      return AmiiboList();
    }
    final List<AmiiboModel> matches = amiibo.where((AmiiboModel a) {
      final String name = I18n.of(context).text(a.id);
      final bool m = regex.hasMatch(name);
      return m;
    }).toList();
    return AmiiboList.from(matches);
  }

  // Transform into regular exression.
  RegExp _queryToPattern(String str) {
    final List<String> keywords = str
        .split(' ')
        .map<String>((String keyword) => keyword.trim().toLowerCase())
        .where((String keyword) => keyword.isNotEmpty)
        .toSet() // Remove duplicates.
        .toList();
    String pattern = '';
    if (keywords.isNotEmpty) {
      pattern = keywords[0];
      for (int i = 1; i < keywords.length; i++) {
        pattern += '|' + keywords[i];
      }
    }
    return RegExp(
      pattern,
      caseSensitive: false,
      multiLine: false,
    );
  }
}
