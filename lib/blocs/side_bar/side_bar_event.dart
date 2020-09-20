part of 'side_bar_bloc.dart';

abstract class SideBarEvent extends Equatable {
  const SideBarEvent();
  @override
  List<Object> get props => [];
}

class SlideBarInitialized extends SideBarEvent {
  final int index;
  final double currentIndexStartYPosition;
  const SlideBarInitialized(
      {@required this.index, @required this.currentIndexStartYPosition});
  @override
  List<Object> get props => [index, currentIndexStartYPosition];
}

class SideBarTabChanged extends SideBarEvent {
  final int index;
  final double currentIndexStartYPosition;

  const SideBarTabChanged(
      {@required this.index, @required this.currentIndexStartYPosition});

  @override
  List<Object> get props => [index, currentIndexStartYPosition];
}
