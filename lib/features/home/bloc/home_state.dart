part of 'home_bloc.dart';

enum HomeStatus { init, loading, success, failure, initLoading }

extension HomeStatusX on HomeStatus {
  bool get isInit => this == HomeStatus.init;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
  bool get isInitLoading => this == HomeStatus.initLoading;
}

enum HomeSortOrder { az, za }

enum HomeSortType { firstName, lastName }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.init,
    this.users = const [],
    this.keyword = '',
    this.sortOrder = HomeSortOrder.az,
    this.sortType = HomeSortType.firstName,
    this.deleteStatus = HomeStatus.init,
  });

  final HomeStatus status;
  final List<User> users;
  final String keyword;
  final HomeSortOrder sortOrder;
  final HomeSortType sortType;
  final HomeStatus deleteStatus;

  HomeState copyWith({
    HomeStatus? status,
    List<User>? users,
    String? keyword,
    HomeSortOrder? sortOrder,
    HomeSortType? sortType,
    HomeStatus? deleteStatus,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      keyword: keyword ?? this.keyword,
      sortOrder: sortOrder ?? this.sortOrder,
      sortType: sortType ?? this.sortType,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [
    status,
    users,
    keyword,
    sortOrder,
    sortType,
    deleteStatus,
  ];
}

extension HomeSortOrderX on HomeSortOrder {
  String get displayName {
    switch (this) {
      case HomeSortOrder.az:
        return 'A-Z';
      case HomeSortOrder.za:
        return 'Z-A';
    }
  }

  Map<String, dynamic> toFilterObject() {
    switch (this) {
      case HomeSortOrder.az:
        return {'order': 'asc'};
      case HomeSortOrder.za:
        return {'order': 'desc'};
    }
  }
}
