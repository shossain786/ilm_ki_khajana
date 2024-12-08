import 'package:equatable/equatable.dart';

abstract class IrshadateState extends Equatable {
  const IrshadateState();

  @override
  List<Object> get props => [];
}

class IrshadateInitial extends IrshadateState {}

class IrshadateLoading extends IrshadateState {}

class IrshadateLoaded extends IrshadateState {
  final List<Map<String, dynamic>> irshadate;

  const IrshadateLoaded(this.irshadate);

  @override
  List<Object> get props => [irshadate];
}

class IrshadateError extends IrshadateState {
  final String message;

  const IrshadateError(this.message);

  @override
  List<Object> get props => [message];
}

class AddIrshadateState extends IrshadateState { // Renamed to AddIrshadateState
  final String content;
  final String category;
  final String date;

  const AddIrshadateState({required this.content, required this.category, required this.date});

  @override
  List<Object> get props => [content, category, date];
}
