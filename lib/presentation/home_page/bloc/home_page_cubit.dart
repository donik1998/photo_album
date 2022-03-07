import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';
import 'package:photo_album/presentation/home_page/layouts/home_page_large_layout.dart';
import 'package:photo_album/presentation/home_page/layouts/home_page_mobile_layout.dart';
import 'package:photo_album/presentation/theme/layout_decider.dart';

class HomePageCubit extends Cubit<HomePageState> with LayoutDecider {
  HomePageCubit() : super(HomePageInitial());

  GlobalKey<FormState> createContentFormKey = GlobalKey<FormState>();
  TextEditingController contentTitleController = TextEditingController();
  TextEditingController contentWidthController = TextEditingController();
  TextEditingController contentHeightController = TextEditingController();

  int currentPageIndex = 0;

  PlatformFile? selectedFile;

  void changeCurrentIndex(int newIndex) {
    currentPageIndex = newIndex;
    emit(this.state.copyWith(index: newIndex));
  }

  Future<void> addContent() async {}

  @override
  Widget get largeLayout => HomePageLargeLayout();

  @override
  Widget get tabletLayout => HomePageLargeLayout();

  @override
  Widget get mobileLayout => HomePageMobileLayout();

  @override
  Future<void> close() {
    contentTitleController.dispose();
    contentWidthController.dispose();
    contentHeightController.dispose();
    return super.close();
  }

  Future<void> saveData(DecorationCategory? selectedCategory) async {
    if (selectedFile == null) {
      emit(HomePageError(error: 'Вы не выбрали файл', pageIndex: state.pageIndex));
    }
    if ((createContentFormKey.currentState?.validate() ?? false) && selectedFile != null && selectedCategory != null) {
      emit(HomePageLoading(pageIndex: state.pageIndex));
      try {
        TaskSnapshot uploadTask =
            await FirebaseStorage.instance.ref('${selectedCategory.type}/${selectedFile!.name}').putData(selectedFile!.bytes!);
        String downloadLink = await uploadTask.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('decorations').add(
              DecorationElement(
                downloadLink: downloadLink,
                title: contentTitleController.text,
                height: double.tryParse(contentHeightController.text) ?? 0,
                width: double.tryParse(contentWidthController.text) ?? 0,
                type: selectedCategory.type,
              ).toMap,
            );
        contentTitleController.clear();
        contentHeightController.clear();
        contentWidthController.clear();
        emit(HomePageSuccess(
          pageIndex: state.pageIndex,
          successMessage: 'Контент успешно загружен',
          categoriesList: state.categoriesList,
        ));
      } catch (e) {
        print(e.toString());
        emit(HomePageError(error: e.toString(), pageIndex: state.pageIndex));
      }
    }
  }

  void changeSelectedFile(PlatformFile file) {
    selectedFile = file;
  }

  showMessage(String message) => emit(HomePageSuccess(
        pageIndex: state.pageIndex,
        successMessage: message,
        categoriesList: state.categoriesList,
      ));
}
