import 'package:demo_bloc/searching/bloc/searching_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  final bloc = SearchingBloc();
  TextEditingController _sarchingController = TextEditingController();
  @override
  void initState() {
    bloc.add(SearchingInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _sarchingController,
                onChanged: (value) {
                  // print(value.trim());
                  if (value.trim().isNotEmpty) {
                    bloc.add(SearchingKeyWordEvent(searchingKey: value.trim()));
                  } else {
                    bloc.add(SearchingEmtyEvent());
                  }
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            BlocConsumer<SearchingBloc, SearchingState>(
              bloc: bloc,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case SearchingLoadingState:
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  case SearchingSuccessState:
                    state as SearchingSuccessState;
                    return Expanded(
                      child: _sarchingController.text.isEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) => ListTile(
                                  title: Text(state.modelList[index].titile
                                      .toString())),
                              itemCount: state.modelList.length,
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) => ListTile(
                                  title: Text(state.modelList[index].titile
                                      .toString())),
                              itemCount: state.modelList.length,
                            ),
                    );

                  default:
                    return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
