part of 'jorbs_bloc.dart';

@immutable
abstract class JorbsEvent {}

// If the user pressed Save buttom in the PopUp srceen this Event will occur.
class FilterGotSaved extends JorbsEvent {}
