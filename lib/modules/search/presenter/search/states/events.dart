abstract class SearchEvent {}

class GetSearchEvent extends SearchEvent {
  final String searchText;

  GetSearchEvent(this.searchText);
}

class IncrementPageEvent extends SearchEvent {}
