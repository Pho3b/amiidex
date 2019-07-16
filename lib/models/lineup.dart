import 'package:amiidex/models/amiibo.dart';
import 'package:amiidex/models/amiibo_list.dart';
import 'package:amiidex/models/serie.dart';
import 'package:amiidex/models/serie_list.dart';

class LineupModel {
  const LineupModel(this._series, this._amiibo);

  factory LineupModel.fromJson(Map<String, dynamic> json) {
    assert(json['lineup'] != null);

    final Map<String, SerieModel> series = <String, SerieModel>{};
    final Map<String, AmiiboModel> amiibo = <String, AmiiboModel>{};

    json['lineup'].forEach((dynamic s) {
      final SerieModel serie = SerieModel.fromJson(s);
      series[serie.id] = serie;
      for (AmiiboModel a in serie.amiibo) {
        amiibo[a.id] = a;
      }
    });

    return LineupModel(series, amiibo);
  }

  final Map<String, SerieModel> _series;
  final Map<String, AmiiboModel> _amiibo;

  SerieList get series => SerieList.from(_series.values);

  SerieModel getSerieById(String id) {
    assert(_series.containsKey(id));
    return _series[id];
  }

  AmiiboList get amiibo => AmiiboList.from(_amiibo.values);

  int get amiiboCount => _amiibo.length;

  AmiiboModel getAmiiboById(String id) {
    assert(_amiibo.containsKey(id));
    return _amiibo[id];
  }

  AmiiboList matchBarcode(String barcode) {
    for (AmiiboModel a in amiibo) {
      final bool match = a.matchBarcode(barcode);
      if (match) {
        return AmiiboList.from(<AmiiboModel>[a]);
      }
    }
    return AmiiboList();
  }
}
