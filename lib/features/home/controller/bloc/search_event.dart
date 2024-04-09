part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class FilterByLowToHigh extends SearchEvent {}

class FilterByHighToLow extends SearchEvent {}

class FilterByUnder999 extends SearchEvent {}

class FilterByAll extends SearchEvent {}

class SearchProductEvent extends SearchEvent {
  final String query;
  SearchProductEvent({required this.query});
}
