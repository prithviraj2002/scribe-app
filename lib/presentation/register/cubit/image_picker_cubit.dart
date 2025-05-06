import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCubit extends Cubit<String>{
  ImagePickerCubit(): super("");

  void selectImage() async{
    ImagePicker picker = ImagePicker();

    XFile? imagePath = await picker.pickImage(source: ImageSource.gallery);

    if(imagePath != null){
      emit(imagePath.path);
    }
    else{
      emit("");
    }
  }

  void uploadImage(){
    if(state.isNotEmpty){
      //ToDo: Implement image upload.
    }
  }
}