import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/ad.dart';

enum CreateState { IDLE, LOADING, DONE }

class CreateBloc {

  CreateBloc() {
    _stateController.add(CreateState.IDLE);
  }

  final _stateController = BehaviorSubject<CreateState>();
  Stream<CreateState> get outState => _stateController.stream;

  Future<bool> saveAd(Ad ad) async {
    _stateController.add(CreateState.LOADING);

    await Future.delayed(Duration(seconds: 2));

    _stateController.add(CreateState.DONE);
    return true;
  }

  void dispose() {
    _stateController.close();
  }
}