import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'side_bar_event.dart';
part 'side_bar_state.dart';

class SideBarBloc extends Bloc<SideBarEvent, SideBarState> {
  SideBarBloc() : super(SideBarState());

  @override
  Stream<SideBarState> mapEventToState(
    SideBarEvent event,
  ) async* {
    if (event is SlideBarInitialized) {
      add(SideBarTabChanged(
          index: event.index,
          currentIndexStartYPosition: event.currentIndexStartYPosition));
    } else if (event is SideBarTabChanged) {
      yield _mapSideBarTabChangedToState(event, state);
    }
  }

  SideBarState _mapSideBarTabChangedToState(
    SideBarTabChanged event,
    SideBarState state,
  ) {
    return state.copyWith(
        selectedIndex: event.index,
        currentIndexStartYPosition: event.currentIndexStartYPosition);
  }
}
