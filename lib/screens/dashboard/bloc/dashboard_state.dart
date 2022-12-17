part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final User? user;

  const DashboardState({
    this.user,
  });

  @override
  List<Object?> get props => [user];

  DashboardState copyWith({
    User? user,
  }) {
    return DashboardState(
      user: user ?? this.user,
    );
  }
}
