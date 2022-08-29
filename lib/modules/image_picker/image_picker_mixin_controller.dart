 import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selftable_task/modules/image_picker/image_picker_functions.dart';

mixin ImagePickerMixinController on GetxController {
  XFile? pikedImageFile;
  List<XFile> imagesListFiles = [];
  Function? onGetImage;

  openMultiImagePicker() async {
    ImagePickerFunctions.openImagePicker(onGalleryPressed: () async {
      await ImagePickerFunctions.selectMultipleImages(
          onGetImages: (List<XFile> imagesFiles) {
        imagesListFiles.addAll(imagesFiles);
        update();
      }, onGetErrors: (e) {
        print("error in openImagePicker: ${e.toString()}");
      });
    }, onCameraPressed: () async {
      await ImagePickerFunctions.pickOneImagePressed(
          source: ImageSource.camera,
          onGetImage: (XFile imageFile) {
            imagesListFiles.add(XFile(imageFile.path));
            update();
          },
          onGetError: (e) {
            print("error in openImagePicker: ${e.toString()}");
          });
    });
  }

  removeImageFromList(XFile imageFile) {
    imagesListFiles.remove(imageFile);
    update();
  }

  addProfileImage({required onGetImage}) async {
    ImagePickerFunctions.openImagePicker(onGetImage: (XFile imageFile) {
      pikedImageFile = imageFile;
      onGetImage(imageFile);
      update();
    }, onGetError: (e) {
      onGetImage(null);
      print("error in openImagePicker: ${e.toString()}");
    });
  }
}
