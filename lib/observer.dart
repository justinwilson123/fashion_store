import 'package:flutter_bloc/flutter_bloc.dart';

class MyObserver extends BlocObserver {
  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   print("===========================OnChange");
  //   print(bloc);
  //   print(change);
  //   print("===========================OnChange");
  //   super.onChange(bloc, change);
  // }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   print("===========================OnEvent");
  //   print(bloc);
  //   print(event);
  //   print("===========================OnEvent");
  //   super.onEvent(bloc, event);
  // }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   print("===========================tanslation");
  //   print(bloc);
  //   print(transition);
  //   print("===========================traonslation");
  //   super.onTransition(bloc, transition);
  // }

  @override
  void onClose(BlocBase bloc) {
    print(bloc);
    super.onClose(bloc);
  }
}
