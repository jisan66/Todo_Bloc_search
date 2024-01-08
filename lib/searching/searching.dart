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
                  bloc.add(SearchingKeyWordEvent(searchingKey: value.trim()));
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),


            BlocBuilder<SearchingBloc, SearchingState>(
              bloc: bloc,
              builder: (context, state) {
                {
                  if (state is SearchingLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchingSuccessState) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                            title:
                                Text(state.modelList[index].titile.toString())),
                        itemCount: state.modelList.length,
                      ),
                    );
                  }

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
