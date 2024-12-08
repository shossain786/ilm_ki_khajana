import 'package:equatable/equatable.dart';

abstract class IrshadateEvent extends Equatable {
  const IrshadateEvent();

  @override
  List<Object> get props => [];
}

class SyncIrshadate extends IrshadateEvent {}

class AddIrshadateEvent extends IrshadateEvent {
  final String content;
  final String category;
  final String date;

  const AddIrshadateEvent({
    required this.content,
    required this.category,
    required this.date,
  });

  @override
  List<Object> get props => [content, category, date];
}

class FetchIrshadate extends IrshadateEvent {}  // Added the FetchIrshadate event
