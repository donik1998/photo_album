import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_album/presentation/state/base_provider.dart';

class ProfilePageState extends BaseProvider {
  ImagePicker _picker = ImagePicker();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: FirebaseAuth.instance.currentUser?.displayName);

  Future<String> uploadPhoto({required ImageSource source}) async {
    try {
      final pickedImage = await _picker.pickImage(source: source, preferredCameraDevice: CameraDevice.front);
      if (pickedImage != null) {
        setLoading(true);
        var bytes = await FlutterImageCompress.compressWithFile(
          pickedImage.path,
          quality: 50,
          format: CompressFormat.png,
          minHeight: 512,
          minWidth: 512,
        );
        String carImageLink = '';
        String fileExtension = pickedImage.path.split('/').last.split('.').last;
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('user_photos/${FirebaseAuth.instance.currentUser!.uid}.$fileExtension')
            .putData(bytes!);
        TaskSnapshot taskSnapshot = await uploadTask;
        carImageLink = await taskSnapshot.ref.getDownloadURL();
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(carImageLink);
        setLoading(false);
        return 'Успешно добавлено';
      }
      return 'Выбор фото отменен';
    } catch (e) {
      return 'Произошла ошибка при изменении фото';
    }
  }

  Future<String> onNameSaved() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.currentUser?.updateDisplayName(nameController.text);
        notifyListeners();
        return 'Имя изменено';
      } catch (e) {
        return 'Ошибка изменения имени';
      }
    }
    return '';
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
