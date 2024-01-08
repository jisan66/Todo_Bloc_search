// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'searching_bloc.dart';

@immutable
sealed class SearchingEvent {}

class SearchingInitialEvent extends SearchingEvent {}

class SearchingKeyWordEvent extends SearchingEvent {
  final String searchingKey;
  SearchingKeyWordEvent({
    required this.searchingKey,
  });
}

class SearchingEmtyEvent extends SearchingEvent {}
