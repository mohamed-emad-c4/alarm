part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeAlarm extends HomeState {}
final class HomeClock extends HomeState {}
final class HomeSetting extends HomeState {}


