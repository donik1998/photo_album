class HomePageState {
  final int pageIndex;

  HomePageState({required this.pageIndex});

  HomePageState copyWith({int? index}) => HomePageState(pageIndex: index ?? this.pageIndex);
}

class HomePageInitial extends HomePageState {
  HomePageInitial() : super(pageIndex: 0);
}

class HomePageLoading extends HomePageState {
  HomePageLoading({required int pageIndex}) : super(pageIndex: pageIndex);
}

class HomePageSuccess extends HomePageState {
  final String successMessage;
  HomePageSuccess({required int pageIndex, this.successMessage = ''}) : super(pageIndex: pageIndex);
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError({required this.error, required int pageIndex}) : super(pageIndex: pageIndex);
}
