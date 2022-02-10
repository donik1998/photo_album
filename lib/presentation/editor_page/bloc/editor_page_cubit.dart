import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/editor_page/bloc/editor_page_state.dart';

class EditorPageCubit extends Cubit<EditorPageState> {
  EditorPageCubit() : super(EditorPageInitial());

}