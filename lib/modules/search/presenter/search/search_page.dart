import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:clean_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/events.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: TextField(
              onChanged: (value) => bloc.add(GetSearchEvent(value)),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search...",
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return Center(
                    child: Text('Digite um texto'),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Text('Houve um error'),
                  );
                }

                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollNotification) {
                    // print(scrollNotification.metrics.pixels);
                    // print(scrollNotification.metrics.maxScrollExtent);
                    if (!(state is SearchLoading) &&
                        scrollNotification.metrics.pixels >=
                            scrollNotification.metrics.maxScrollExtent - 300) {
                      // bloc.add(IncrementPageEvent());
                      return true;
                    }

                    return false;
                  },
                  child: ListView.builder(
                    itemCount: bloc.list.length + 1,
                    itemBuilder: (_, index) {
                      if (index < bloc.list.length) {
                        final item = bloc.list[index];

                        return ListTile(
                          leading: item.img == null
                              ? Container()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(item.img),
                                ),
                          title: Text(item.title ?? ""),
                          subtitle: Text(item.content ?? ""),
                        );
                      } else {
                        return _buildLoadMoreButton(
                          isLoading: state is SearchLoadingMore,
                          onPressed: () => bloc.add(IncrementPageEvent()),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton({bool isLoading, void Function() onPressed}) {
    return Center(
      heightFactor: 2,
      child: ElevatedButton(
        child: isLoading
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Text('Load more'),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40),
        ),
      ),
    );
  }
}
