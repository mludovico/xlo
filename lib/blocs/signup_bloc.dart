import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/user.dart';

enum SignupState {IDLE, LOADING, ERROR}

class SignupBlocState{
  SignupState state;
  String errorMessage;

  SignupBlocState(this.state, {this.errorMessage});
}

class SignupBloc{
  final BehaviorSubject<SignupBlocState> _stateController =
    BehaviorSubject<SignupBlocState>.seeded(SignupBlocState(SignupState.IDLE));
  Stream<SignupBlocState> get outState => _stateController.stream;

  User user = User();

  void name(String name) => user.name = name;
  void email(String email) => user.email = email;
  void password(String password) => user.password = password;

  void signUp() async {
    _stateController.add(SignupBlocState(SignupState.LOADING));
    await Future.delayed(Duration(seconds: 3));
    _stateController.add(SignupBlocState(SignupState.IDLE));
  }

  void dispose(){
    _stateController.close();
  }
}