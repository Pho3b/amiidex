import 'package:amiidex/UI/views/detail.dart';
import 'package:flutter/material.dart';
import 'package:amiidex/models/serie.dart';
import 'package:amiidex/models/serie_list.dart';
import 'package:amiidex/providers/owned.dart';
import 'package:amiidex/util/theme.dart';
import 'package:provider/provider.dart';

class SerieGridItem extends StatelessWidget {
  const SerieGridItem({
    Key key,
    @required this.series,
    @required this.serie,
  }) : super(key: key);

  final SeriesList series;
  final SerieModel serie;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ItemCardThemeData itemCardData = ItemCardThemeData(data: themeData);
    final OwnedProvider ownedProvider = Provider.of<OwnedProvider>(context);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          maintainState: true,
          builder: (BuildContext context) => DetailView(
            series: series,
            serie: serie,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CustomMultiChildLayout(
          delegate:
              _LayoutDelegate(serie, ownedProvider.percentOwnedInSerie(serie)),
          children: <Widget>[
            LayoutId(
              id: 'image-background-box',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 6.0,
                      spreadRadius: 3.0,
                    ),
                  ],
                  // TODO(cbonello): Theme dependent.
                  color: Colors.white,
                ),
              ),
            ),
            LayoutId(
              id: 'text-background-box1',
              child: Container(
                color: itemCardData.backgroundColor1,
              ),
            ),
            LayoutId(
              id: 'text-background-box2',
              child: Container(
                color: itemCardData.backgroundColor2,
              ),
            ),
            LayoutId(
              id: 'image',
              child: serie.logo,
            ),
            LayoutId(
              id: 'caption',
              child: Center(
                child: Text(
                  '${ownedProvider.ownedInSerie(serie)}/${serie.amiibo.length}',
                  style: TextStyle(
                    color: itemCardData.color,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LayoutDelegate extends MultiChildLayoutDelegate {
  _LayoutDelegate(this.serie, this.percentOwned);

  final SerieModel serie;
  final double percentOwned;

  @override
  void performLayout(Size size) {
    if (hasChild('image-background-box')) {
      layoutChild(
        'image-background-box',
        BoxConstraints.expand(width: size.width, height: size.height),
      );
      positionChild('image-background-box', const Offset(0, 0));
    }

    if (hasChild('text-background-box1')) {
      final double height = size.height * 0.25;
      layoutChild(
        'text-background-box1',
        BoxConstraints.tightFor(width: size.width, height: height),
      );
      positionChild('text-background-box1', Offset(0, size.height - height));
    }

    if (hasChild('text-background-box2')) {
      final double height = size.height * 0.25;
      layoutChild(
        'text-background-box2',
        BoxConstraints.tightFor(
            width: size.width * percentOwned, height: height),
      );
      positionChild('text-background-box2', Offset(0, size.height - height));
    }

    if (hasChild('image')) {
      final double height = size.height * 0.75;
      final Size layoutSize = layoutChild(
        'image',
        BoxConstraints.tightFor(width: size.width * 0.8),
      );
      positionChild(
        'image',
        Offset((size.width - layoutSize.width) / 2,
            (height - layoutSize.height) / 2),
      );
    }

    if (hasChild('caption')) {
      final double height = size.height * 0.25;
      layoutChild(
        'caption',
        BoxConstraints(maxWidth: size.width, maxHeight: height),
      );
      positionChild('caption', Offset(0, size.height - height));
    }
  }

  @override
  bool shouldRelayout(_LayoutDelegate oldDelegate) => false;
}
