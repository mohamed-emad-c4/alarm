import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void changeToClock() => emit(HomeClock());
  void changeToAlarm() => emit(HomeAlarm());
  void changeToSetting() => emit(HomeSetting());
}
