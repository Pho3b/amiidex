import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:amiidex/UI/home/views/webview.dart';
import 'package:amiidex/models/amiibo.dart';
import 'package:amiidex/providers/lock.dart';
import 'package:amiidex/providers/owned.dart';
import 'package:amiidex/providers/region.dart';
import 'package:amiidex/util/i18n.dart';
import 'package:amiidex/util/theme.dart';
import 'package:provider/provider.dart';

class AmiiboListItem extends StatelessWidget {
  const AmiiboListItem({
    Key key,
    @required this.amiibo,
    this.helpMessageDelegate,
  }) : super(key: key);

  final AmiiboModel amiibo;
  final Function helpMessageDelegate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 100,
              child: _Item(
                  amiibo: amiibo, helpMessageDelegate: helpMessageDelegate),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    Key key,
    @required this.amiibo,
    @required this.helpMessageDelegate,
  }) : super(key: key);

  final AmiiboModel amiibo;
  final Function helpMessageDelegate;

  @override
  __ItemState createState() => __ItemState();
}

class __ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ItemCardThemeData itemCardData = ItemCardThemeData(data: themeData);
    final RegionProvider regionProvider = Provider.of<RegionProvider>(context);
    final LockProvider lockProvider = Provider.of<LockProvider>(context);
    final OwnedProvider ownedProvider = Provider.of<OwnedProvider>(context);

    return CustomMultiChildLayout(
      delegate: _LayoutDelegate(),
      children: <Widget>[
        LayoutId(
          id: 'image-background-box',
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 6.0,
                      spreadRadius: 3.0,
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: ownedProvider.isOwned(widget.amiibo.id)
                    ? const Icon(
                        Icons.check,
                        color: Color(0xFF5CA0E5),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        LayoutId(
          id: 'text-background-box',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),
              color: ownedProvider.isOwned(widget.amiibo.id)
                  ? itemCardData.backgroundColor2
                  : itemCardData.backgroundColor1,
            ),
          ),
        ),
        LayoutId(
          id: 'image',
          child: GestureDetector(
            onDoubleTap: () async => Navigator.push(
              context,
              MaterialPageRoute<void>(
                maintainState: true,
                builder: (BuildContext context) =>
                    WebsiteView(url: widget.amiibo.url),
              ),
            ),
            onLongPress: () async {
              if (lockProvider.isOpened) {
                if (widget.helpMessageDelegate != null) {
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.helpMessageDelegate(
                          I18n.of(context).text(widget.amiibo.id),
                        ),
                      ),
                    ),
                  );
                }
                await SystemSound.play(SystemSoundType.click);
                ownedProvider.toggleAmiiboOwnership(widget.amiibo.id);
              }
            },
            child: Container(
              foregroundDecoration: ownedProvider.isOwned(widget.amiibo.id)
                  ? null
                  : BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
              child: Center(child: widget.amiibo.image),
            ),
          ),
        ),
        LayoutId(
          id: 'caption',
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  I18n.of(context).text(widget.amiibo.id),
                  style: TextStyle(
                    color: itemCardData.color,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.amiibo.wasReleasedInRegion(regionProvider.regionId)
                      ? DateFormat.yMMMd(
                          Localizations.localeOf(context).toString(),
                        ).format(
                          widget.amiibo.releaseDate(regionProvider.regionId))
                      : 'N/A',
                  style: TextStyle(
                    color: itemCardData.color,
                    fontSize: 14.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final double imageHeight = size.height * 0.9;
    final double textBackgroundWidth = size.width * 2.0 / 3.0;
    final double imageWidth = (size.width - textBackgroundWidth) * 0.9;

    if (hasChild('image-background-box')) {
      layoutChild(
        'image-background-box',
        BoxConstraints.expand(width: size.width, height: size.height),
      );
      positionChild('image-background-box', const Offset(0, 0));
    }

    if (hasChild('text-background-box')) {
      layoutChild(
        'text-background-box',
        BoxConstraints.expand(width: textBackgroundWidth, height: size.height),
      );
      positionChild(
          'text-background-box', Offset(size.width - textBackgroundWidth, 0));
    }

    if (hasChild('image')) {
      final Size img = layoutChild(
        'image',
        BoxConstraints.loose(Size(imageWidth, imageHeight)),
      );
      positionChild(
          'image',
          Offset(((size.width - textBackgroundWidth) - img.width) / 2,
              (size.height - img.height) / 2.0));
    }

    if (hasChild('caption')) {
      final double height = size.height * 0.9;
      layoutChild(
        'caption',
        BoxConstraints(maxWidth: textBackgroundWidth, maxHeight: height),
      );
      positionChild(
          'caption',
          Offset(
              size.width - textBackgroundWidth, (size.height - height) / 2.0));
    }
  }

  @override
  bool shouldRelayout(_LayoutDelegate oldDelegate) => false;
}
