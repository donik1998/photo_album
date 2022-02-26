import 'package:photo_album/data/models/content_category.dart';

class HomePageState {
  final int pageIndex;
  final List<ContentCategory> categoriesList;

  HomePageState({
    required this.pageIndex,
    this.categoriesList = const [],
  });

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

  HomePageSuccess({
    required int pageIndex,
    this.successMessage = '',
    required List<ContentCategory> categoriesList,
  }) : super(pageIndex: pageIndex, categoriesList: categoriesList);
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError({required this.error, required int pageIndex}) : super(pageIndex: pageIndex);
}
