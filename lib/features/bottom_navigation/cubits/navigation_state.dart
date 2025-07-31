part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final RequestState<Unit> navState;

  NavigationState.initial() : navState = RequestState.initial();
  const NavigationState({required this.navState});

  NavigationState copyWith({
    RequestState<Unit>? navState,
  }) {
    return NavigationState(
      navState: navState ?? this.navState,
    );
  }

  @override
  List<Object?> get props => [navState];
}
