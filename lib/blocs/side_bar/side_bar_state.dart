part of 'side_bar_bloc.dart';

class SideBarState extends Equatable {
  const SideBarState({this.currentIndex, this.currentIndexStartYPosition});

  final int currentIndex;
  final double currentIndexStartYPosition;

  SideBarState copyWith(
          {int selectedIndex, double currentIndexStartYPosition}) =>
      SideBarState(
          currentIndex: selectedIndex ?? this.currentIndex,
          currentIndexStartYPosition:
              currentIndexStartYPosition ?? this.currentIndexStartYPosition);

  @override
  List<Object> get props => [currentIndex, currentIndexStartYPosition];
}
