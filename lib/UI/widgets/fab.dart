import 'package:amiidex/UI/widgets/amiibo_box.dart';
import 'package:amiidex/models/amiibo.dart';
import 'package:amiidex/models/amiibo_box.dart';
import 'package:amiidex/main.dart';
import 'package:amiidex/providers/fab_visibility.dart';
import 'package:amiidex/providers/lock.dart';
import 'package:amiidex/providers/owned.dart';
import 'package:amiidex/services/assets.dart';
import 'package:amiidex/util/dialogs.dart';
import 'package:amiidex/util/i18n.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class FABScan extends StatelessWidget {
  const FABScan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LockProvider lockProvider = Provider.of<LockProvider>(context);
    final FABVisibility fabVisibility = Provider.of<FABVisibility>(context);

    return Visibility(
      visible: fabVisibility.isVisible && lockProvider.isOpened,
      child: FloatingActionButton(
        child: const Icon(Icons.camera_enhance),
        onPressed: () {
          scan(context);
        },
      ),
    );
  }

  Future<void> scan(BuildContext context) async {
    try {
      final String barcode = await BarcodeScanner.scan();
      await _addAmiiboDialog(context, barcode);
    } on PlatformException catch (e) {
      if (e.code != BarcodeScanner.CameraAccessDenied) {
        await okDialog(
          context,
          Text(I18n.of(context).text('error-dialog-title')),
          <Widget>[Text(e.message)],
        );
      }
    } on FormatException {
      // User pressed the "back"-button before scanning anything.
    } catch (e) {
      await okDialog(
        context,
        Text(I18n.of(context).text('error-dialog-title')),
        <Widget>[Text(e.message)],
      );
    }
  }

  Future<void> _addAmiiboDialog(
    BuildContext context,
    String barcode,
  ) async {
    final OwnedProvider ownedProvider = Provider.of<OwnedProvider>(context);
    final AssetsService assetsService = locator<AssetsService>();
    final AmiiboBoxModel box = assetsService.amiiboLineup.matchBarcode(barcode);

    // Unknown barcode?
    if (box == null) {
      await errorDialog(
        context,
        Text(I18n.of(context).text('fab-scan-error-dialog-title')),
        <Widget>[
          Text(
            sprintf(
              I18n.of(context).text('fab-scan-unknown-barcode'),
              <String>[barcode],
            ),
          ),
        ],
      );
      return;
    }

    final bool isOwned = box.amiibo
        .map<bool>((AmiiboModel a) => ownedProvider.isOwned(a.id))
        .reduce((bool v, bool e) => v && e);

    final bool add = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(I18n.of(context).text('fab-scan-add-dialog-title')),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  sprintf(
                    I18n.of(context).text('fab-scan-barcode'),
                    <String>[barcode],
                  ),
                ),
                const SizedBox(height: 20.0),
                AmiiboWidget(box: box),
                const SizedBox(height: 15.0),
                if (isOwned)
                  Text(I18n.of(context).text('fab-scan-add-dialog-owned'))
                else
                  Text(I18n.of(context).text('fab-scan-add-dialog-add')),
              ],
            ),
          ),
          actions: <Widget>[
            if (isOwned == false)
              RaisedButton(
                color: const Color(0xFF218AE6),
                textColor: Colors.white,
                child: Text(I18n.of(context).text('cancel-button')),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            if (isOwned == false)
              RaisedButton(
                color: const Color(0xFF218AE6),
                textColor: Colors.white,
                child: Text(I18n.of(context).text('add-button')),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            else
              RaisedButton(
                color: const Color(0xFF218AE6),
                textColor: Colors.white,
                child: Text(I18n.of(context).text('ok-button')),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
          ],
        );
      },
    );

    if (add) {
      box.amiibo.forEach(ownedProvider.setOwned);
    }
  }
}
