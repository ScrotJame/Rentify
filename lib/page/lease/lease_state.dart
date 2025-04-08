part of 'lease_cubit.dart';

abstract class LeaseState extends Equatable {
  const LeaseState();

  @override
  List<Object?> get props => [];
}

class LeaseInitial extends LeaseState {}

class LeaseLoading extends LeaseState {}

class LeaseSuccess extends LeaseState {
  final List<Viewing> viewings;

  const LeaseSuccess(this.viewings);

  @override
  List<Object?> get props => [viewings];
}

class LeaseError extends LeaseState {
  final String message;

  const LeaseError(this.message);

  @override
  List<Object?> get props => [message];
}