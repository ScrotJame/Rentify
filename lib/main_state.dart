part of 'main_cubit.dart';

class MainState extends Equatable {
  final bool isLightTheme;
  final TabItem selected;

  const MainState({
    required this.isLightTheme,
    required this.selected,
  });

  factory MainState.initial() => const MainState(
    isLightTheme: true,
    selected: TabItem.home,
  );

  MainState copyWith({
    bool? isLightTheme,
    TabItem? selected,
  }) {
    return MainState(
      isLightTheme: isLightTheme ?? this.isLightTheme,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [isLightTheme, selected];
}
