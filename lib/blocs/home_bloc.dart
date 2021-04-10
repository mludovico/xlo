import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/ad.dart';

class HomeBloc{

  final BehaviorSubject<String> _searchController = BehaviorSubject<String>();
  final BehaviorSubject<List<Ad>> _adsController = BehaviorSubject<List<Ad>>();
  Stream<String> get outSearch => _searchController.stream;
  Stream<List<Ad>> get outAds => _adsController.stream;
  List<Ad> _adList = <Ad>[];

  HomeBloc() {
    _adsController.add(_adList);
  }

  void addAd(Ad ad) {
    _adList.add(ad);
    _adsController.add(_adList);
  }

  void setSearch(String search){
    _searchController.add(search);
  }

  void dispose(){
    _searchController.close();
    _adsController.close();
  }
}