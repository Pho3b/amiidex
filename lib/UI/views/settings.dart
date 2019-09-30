import 'dart:collection';

import 'package:amiidex/main.dart';
import 'package:amiidex/models/country.dart';
import 'package:amiidex/providers/lock.dart';
import 'package:amiidex/providers/region_indicators.dart';
import 'package:amiidex/services/assets.dart';
import 'package:amiidex/services/local_storage.dart';
import 'package:amiidex/util/form.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:amiidex/providers/owned.dart';
import 'package:amiidex/providers/preferred_language.dart';
import 'package:amiidex/util/i18n.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();
  bool displaySplashScreen, displayOnboarding;
  Brightness _brightness;

  @override
  void initState() {
    displaySplashScreen = localStorageService.getDisplaySplashScreen();
    displayOnboarding = localStorageService.getDisplayOnboarding();
    _brightness = DynamicTheme.of(context).brightness;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PreferredLanguageProvider languageProvider =
        Provider.of<PreferredLanguageProvider>(context);
    final OwnedProvider ownedProvider = Provider.of<OwnedProvider>(context);
    final LockProvider lockProvider = Provider.of<LockProvider>(
      context,
      listen: false,
    );
    final RegionIndicatorsProvider regionIndicatorsProvider =
        Provider.of<RegionIndicatorsProvider>(context);
    final AssetsService assetsService = locator<AssetsService>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: theme.appBarTheme.iconTheme,
        title: Text(I18n.of(context).text('drawer-settings')),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text(I18n.of(context).text('settings-general'))),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(I18n.of(context).text('settings-language')),
                ),
                Expanded(
                  flex: 2,
                  child: DropdownButton<Locale>(
                    value: languageProvider.locale,
                    onChanged: (Locale newLang) {
                      languageProvider.language = newLang.toString();
                    },
                    items: <DropdownMenuItem<Locale>>[
                      for (final Locale l in I18n.delegate.supportedLocales)
                        DropdownMenuItem<Locale>(
                          value: l,
                          child: Text(I18n.of(context).text(l.toString())),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          LabeledButton(
            label: I18n.of(context).text('settings-collection'),
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            buttonLabel: I18n.of(context).text('settings-collection-reset'),
            // Cannot reset collection if it is locked.
            onPressed: lockProvider.isOpened && ownedProvider.ownedCount > 0
                ? () async {
                    final bool reset = await _resetDialog(context);
                    if (reset) {
                      ownedProvider.reset();
                    }
                  }
                : null,
          ),
          LabeledButton(
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            buttonLabel: I18n.of(context).text('settings-collection-own-all'),
            onPressed: lockProvider.isOpened &&
                    ownedProvider.isCollectionComplete() == false
                ? () async {
                    final bool ownAll = await _ownAllDialog(context);
                    if (ownAll) {
                      ownedProvider.setCollectionComplete();
                    }
                  }
                : null,
          ),
          ListTile(title: Text(I18n.of(context).text('settings-theme'))),
          LabeledRadio<Brightness>(
            label: I18n.of(context).text('settings-light-theme'),
            padding: const EdgeInsets.only(left: 18.0, right: 20.0),
            value: Brightness.light,
            groupValue: _brightness,
            onChanged: (Brightness newBrightness) {
              setState(() {
                _brightness = newBrightness;
              });
              DynamicTheme.of(context).setBrightness(newBrightness);
            },
          ),
          LabeledRadio<Brightness>(
            label: I18n.of(context).text('settings-dark-theme'),
            padding: const EdgeInsets.only(left: 18.0, right: 20.0),
            value: Brightness.dark,
            groupValue: _brightness,
            onChanged: (Brightness newBrightness) {
              setState(() {
                _brightness = newBrightness;
              });
              DynamicTheme.of(context).setBrightness(newBrightness);
            },
          ),
          ListTile(
            title: Text(I18n.of(context).text('settings-region-indicator')),
          ),
          for (final String regionId in assetsService.config.regions.keys)
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      I18n.of(context).text(regionId),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 2.0),
                  Expanded(
                    flex: 4,
                    child: CountryPickerDropdown(
                      countries:
                          assetsService.config.countriesInRegion(regionId),
                      value: regionIndicatorsProvider.indicators[regionId],
                      onChanged: (CountryModel c) {
                        regionIndicatorsProvider.indicator(regionId, c.lKey);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ListTile(
            title: Text(I18n.of(context).text('settings-startup')),
          ),
          LabeledCheckbox(
            label: I18n.of(context).text('settings-display-splash-screen'),
            padding: const EdgeInsets.only(left: 18.0, right: 20.0),
            value: displaySplashScreen,
            onChanged: (bool display) {
              localStorageService.setDisplaySplashScreen(display);
              setState(() => displaySplashScreen = display);
            },
          ),
          LabeledCheckbox(
            label: I18n.of(context).text('settings-display-onboarding'),
            padding: const EdgeInsets.only(left: 18.0, right: 20.0),
            value: displayOnboarding,
            onChanged: (bool display) {
              localStorageService.setDisplayOnboarding(display);
              setState(() => displayOnboarding = display);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _resetDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(I18n.of(context).text('settings-collection-reset')),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              I18n.of(context).text('settings-collection-reset-question'),
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              child: Text(
                I18n.of(context)
                    .text('settings-collection-reset-cancel-button'),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              child: Text(
                I18n.of(context).text('settings-collection-reset-reset-button'),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _ownAllDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(I18n.of(context).text('settings-collection-own-all')),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              I18n.of(context).text('settings-collection-own-all-question'),
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              child: Text(
                I18n.of(context).text('settings-collection-own-all-no-button'),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              child: Text(
                I18n.of(context).text('settings-collection-own-all-yes-button'),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

class CountryPickerDropdown extends StatefulWidget {
  CountryPickerDropdown({
    Key key,
    @required this.countries,
    this.value,
    @required this.onChanged,
  })  : assert(countries != null && countries.isNotEmpty),
        super(key: key);

  final UnmodifiableListView<CountryModel> countries;
  final String value;
  final ValueChanged<CountryModel> onChanged;

  @override
  _CountryPickerDropdownState createState() => _CountryPickerDropdownState();
}

class _CountryPickerDropdownState extends State<CountryPickerDropdown> {
  @override
  Widget build(BuildContext context) {
    final List<CountryModel> sortedCountries = <CountryModel>[
      ...widget.countries
    ];
    sortedCountries.sort((CountryModel a, CountryModel b) {
      final String aName = I18n.of(context).text(a.lKey);
      final String bName = I18n.of(context).text(b.lKey);
      return aName.compareTo(bName);
    });

    return DropdownButton<CountryModel>(
      value: widget.countries
          .firstWhere((CountryModel c) => c.lKey == widget.value),
      onChanged: (CountryModel c) {
        widget.onChanged(c);
      },
      items: <DropdownMenuItem<CountryModel>>[
        for (final CountryModel c in sortedCountries)
          DropdownMenuItem<CountryModel>(
            value: c,
            child: c.label(context),
          )
      ],
      isExpanded: true,
    );
  }
}
