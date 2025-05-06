import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/domain/model/scribe/scribe_model.dart';

class ScribeRepo{
  ScribeApiService service = getIt<ScribeApiService>();

  Future<dynamic> createScribe(ScribeModel model) => service.createScribe(model);

  Future<ScribeModel> getScribe() => service.getScribe();

  Future<void> updateScribe(Map<String, dynamic> data) => service.updateScribe(data);

  Future<void> delScribe() => service.deleteScribe();

  Future<bool> checkScribe() async{
    final response = await service.checkIfScribeExists();
    if(response['exists']){
      return true;
    }
    else{
      return false;
    }
  }
}