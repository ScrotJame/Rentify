part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final bool isFavorite;
  final String message;

  const FavoriteSuccess({
    required this.isFavorite,
    required this.message,
  });

  @override
  List<Object?> get props => [isFavorite, message];
}

class FavoriteListLoaded extends FavoriteState {
  final List<Favorite> favorites;
  final String message;

  const FavoriteListLoaded({
    required this.favorites,
    required this.message,
  });

  @override
  List<Object?> get props => [favorites, message];
}

class FavoriteError extends FavoriteState {
  final String error;

  const FavoriteError(this.error);

  @override
  List<Object?> get props => [error];
}