import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';
import 'package:photo_album/presentation/home_page/layouts/home_page_large_layout.dart';
import 'package:photo_album/presentation/home_page/layouts/home_page_mobile_layout.dart';
import 'package:photo_album/presentation/home_page/widgets/home_page_add_content_body.dart';
import 'package:photo_album/presentation/home_page/widgets/home_page_decoration_elements_body.dart';
import 'package:photo_album/presentation/home_page/widgets/home_page_orders_body.dart';
import 'package:photo_album/presentation/theme/layout_decider.dart';

class HomePageCubit extends Cubit<HomePageState> with LayoutDecider {
  HomePageCubit() : super(HomePageInitial());

  GlobalKey<FormState> createContentFormKey = GlobalKey<FormState>();
  TextEditingController contentTitleController = TextEditingController();
  TextEditingController contentWidthController = TextEditingController();
  TextEditingController contentHeightController = TextEditingController();

  int currentPageIndex = 0;

  PlatformFile? selectedFile;

  String createDecorationElementChosenType = DecorationElementTypes.STICKER;

  final List<Widget> homePageBodies = [
    HomePageOrdersBody(),
    HomePageDecorationElementsBody(),
    HomePageAddContentBody(),
  ];

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

  void changeCreatingElementType(value) {}

  Future<void> saveData() async {
    if (selectedFile == null) {
      emit(HomePageError(error: 'Вы не выбрали файл', pageIndex: state.pageIndex));
    }
    if ((createContentFormKey.currentState?.validate() ?? false) && selectedFile != null) {
      emit(HomePageLoading(pageIndex: state.pageIndex));
      try {
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref('$createDecorationElementChosenType/${selectedFile!.name.replaceAll('.', '-')}.${selectedFile!.extension}')
            .putData(selectedFile!.bytes!);
        String downloadLink = await uploadTask.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('decorations').add(
              DecorationElement(
                downloadLink: downloadLink,
                title: contentTitleController.text,
                height: double.tryParse(contentHeightController.text) ?? 0,
                width: double.tryParse(contentWidthController.text) ?? 0,
                type: createDecorationElementChosenType,
              ).toMap,
            );
        contentTitleController.clear();
        contentHeightController.clear();
        contentWidthController.clear();
        createDecorationElementChosenType = DecorationElementTypes.STICKER;
        emit(HomePageSuccess(pageIndex: state.pageIndex, successMessage: 'Контент успешно загружен'));
      } catch (e) {
        print(e.toString());
        emit(HomePageError(error: e.toString(), pageIndex: state.pageIndex));
      }
    }
  }

  void changeSelectedFile(PlatformFile file) {
    selectedFile = file;
  }

  showMessage(String message) => emit(HomePageSuccess(pageIndex: state.pageIndex, successMessage: message));
}
