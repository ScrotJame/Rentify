part of 'main_cubit.dart';

class MainState {
  final bool isLightTheme;
  final TabItem selected;

  const MainState({
    required this.isLightTheme,
    required this.selected,
  });

  factory MainState.initial() => const MainState(
    isLightTheme: true, // Mặc định theme sáng
    selected: TabItem.Home, // Mặc định tab Home
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
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is MainState &&
              runtimeType == other.runtimeType &&
              isLightTheme == other.isLightTheme &&
              selected == other.selected);

  @override
  int get hashCode => isLightTheme.hashCode ^ selected.hashCode;

  @override
  String toString() {
    return 'MainState{isLightTheme: $isLightTheme, selected: $selected}';
  }
}


