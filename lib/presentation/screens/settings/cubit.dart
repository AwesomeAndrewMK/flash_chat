import 'package:bloc/bloc.dart';

class NameCubit extends Cubit<String> {
  NameCubit() : super('');

  void changeName(String name) => emit(name);
}
