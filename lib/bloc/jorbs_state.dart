part of 'jorbs_bloc.dart';

@immutable
abstract class JorbsState {}

// Disaply recent jobs by GitHub
class JorbsInitial extends JorbsState {
  JorbsInitial();
}

// Loading jobs from providers
class JobsLoading extends JorbsState {
  JobsLoading();
}

// Show filtered fectched Jobs
class JobsLoaded extends JorbsState {
  final List<Job> filteredJobs;
  JobsLoaded(this.filteredJobs);
}

class JorbsError extends JorbsState {
  final String message;
  JorbsError(this.message);
}
