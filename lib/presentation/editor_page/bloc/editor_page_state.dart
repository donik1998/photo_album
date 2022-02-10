abstract class EditorPageState {}

class EditorPageInitial extends EditorPageState {}

class EditorPageLoading extends EditorPageState {}

class EditorPageSuccess extends EditorPageState {}

class EditorPageError extends EditorPageState {
  final String error;

  EditorPageError({required this.error});
}
