part of 'records_cubit.dart';

abstract class RecordsState extends Equatable {
  const RecordsState();
}

class RecordsInitial extends RecordsState {
  @override
  List<Object> get props => [];
}

class RecordsLoading extends RecordsState {

  //defining states
  @override
  List<Object> get props => [];
}

class RecordsSuccess extends RecordsState {

  final List<Records> records;

  RecordsSuccess({required this.records});

  @override
  List<Object> get props => [records];
}

class RecordsError extends RecordsState {
  @override
  List<Object> get props => [];
}