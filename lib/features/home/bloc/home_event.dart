part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class Init extends HomeEvent {
  const Init();
  @override
  List<Object> get props => [];
}

class SortChanged extends HomeEvent {
  const SortChanged({required this.sortOrder});

  final HomeSortOrder sortOrder;

  @override
  List<Object> get props => [sortOrder];
}

class ContactDeleted extends HomeEvent {
  const ContactDeleted({required this.userId});

  final int userId;

  @override
  List<Object> get props => [userId];
}

class KeywordChanged extends HomeEvent {
  const KeywordChanged({required this.keyword});

  final String keyword;

  @override
  List<Object> get props => [keyword];
}

class SearchSubmitted extends HomeEvent {
  const SearchSubmitted();
  @override
  List<Object> get props => [];
}
