import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const apiUrl = 'https://api.jikan.moe/v4/users';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchUserEvent>(_onSearch,transformer: debounceDroppable(const Duration(milliseconds: 300)));
  }

  final _httpClient = Dio();

  _onSearch (SearchUserEvent event, Emitter<SearchState> emit) async {
    if (event.query.length < 3) return; //api error
    final res = await _httpClient.get ( apiUrl, queryParameters: {
      'q': event.query
    },
    );
    emit(SearchState(users: res.data['data']));
  }
}
