// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'searching_bloc.dart';

@immutable
sealed class SearchingState {}

final class SearchingInitial extends SearchingState {}

abstract class SearchingActionState extends SearchingState {}

class SearchingSuccessState extends SearchingState {
  List<SearchModel> modelList;
  SearchingSuccessState({
    required this.modelList,
  });
}

class SearchingLoadingState extends SearchingState {}

class SearchingErrorState extends SearchingState {}
