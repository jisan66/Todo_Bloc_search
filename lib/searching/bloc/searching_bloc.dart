import 'package:bloc/bloc.dart';
import 'package:demo_bloc/searching/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'searching_event.dart';
part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  SearchingBloc() : super(SearchingInitial()) {
    List<SearchModel> model = SearchModel.initialList;
    on<SearchingInitialEvent>((event, emit) async {
      emit(SearchingLoadingState());

      await Future.delayed(Duration(seconds: 1));
      emit(SearchingSuccessState(modelList: model));
    });

    on<SearchingKeyWordEvent>((event, emit) {
      List<SearchModel> searchingList = model
          .where((element) => element.titile!
              .toLowerCase()
              .contains(event.searchingKey.toLowerCase()))
          .toList();
      List.generate(searchingList.length, (index) {
        print(searchingList[index].name);
      });

      emit(SearchingSuccessState(modelList: searchingList));
    });

    on<SearchingEmtyEvent>((event, emit) {
      emit(SearchingSuccessState(modelList: model));
    });
  }
}
