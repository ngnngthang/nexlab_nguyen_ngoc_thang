import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nguyen_ngoc_thang_nexlab/models/models.dart';
import 'package:nguyen_ngoc_thang_nexlab/repository/repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<Init>(_onInit);
    on<SortChanged>(_onSortChange);
    on<ContactDeleted>(_onContactDelete);
    on<KeywordChanged>(_onKeywordChange);
    on<SearchSubmitted>(_onSearchSubmit);
  }

  final ContactRepository _contactRepo = ContactRepositoryImpl();

  Future<void> _onInit(Init event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.initLoading));

      final response = await _fetchContacts(page: 1);

      emit(state.copyWith(status: HomeStatus.success, users: response));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onSortChange(SortChanged event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final response = await _fetchContacts(
        page: 1,
        sortOrder: event.sortOrder,
        keyword: state.keyword,
      );

      emit(
        state.copyWith(
          status: HomeStatus.success,
          users: response,
          sortOrder: event.sortOrder,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onContactDelete(
    ContactDeleted event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await _contactRepo.deleteContact(userId: event.userId);

      if (!response) {
        emit(state.copyWith(deleteStatus: HomeStatus.failure));
      } else {
        final updatedUsers = state.users
            .where((user) => user.id != event.userId)
            .toList();
        emit(
          state.copyWith(deleteStatus: HomeStatus.success, users: updatedUsers),
        );
      }
    } catch (error) {
      emit(state.copyWith(deleteStatus: HomeStatus.failure));
    }
  }

  void _onKeywordChange(KeywordChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(keyword: event.keyword));
  }

  Future<void> _onSearchSubmit(
    SearchSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final response = await _fetchContacts(
        page: 1,
        sortOrder: state.sortOrder,
        keyword: state.keyword,
      );

      emit(state.copyWith(status: HomeStatus.success, users: response));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<List<User>> _fetchContacts({
    required int page,
    HomeSortOrder? sortOrder,
    String? keyword,
  }) async {
    var queries = <String, dynamic>{};

    if (sortOrder != null) {
      queries = sortOrder.toFilterObject();
    }

    if (keyword != null && keyword.isNotEmpty) {
      queries['q'] = keyword;
    }

    try {
      final response = await _contactRepo.fetchContacts(
        page: page,
        filters: {'sortBy': 'firstName', ...queries},
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
