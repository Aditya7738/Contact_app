import 'package:contact_app/src/core/network/api_response.dart';
import 'package:contact_app/src/core/network/apihelper.dart';
import 'package:contact_app/src/models/contactRequestModel.dart';

class ContactRepository{
  Future<ApiResponse> getAllContact() async{
    ApiResponse apiResponse = await ApiHelper().makeGetRequest("contact");
    return apiResponse;
  }
  
  Future<ApiResponse> createNewContact(ContactRequestModel contactRequestModel) async {
    ApiResponse apiResponse =
    await ApiHelper().makePostRequest("contact",
        body: contactRequestModel.toJson());
        return apiResponse;
  }

  Future<ApiResponse> updateContact(ContactRequestModel contactRequestModel) async {
    ApiResponse apiResponse = await ApiHelper().makePatchRequest("contact/${contactRequestModel.id}",
        body: contactRequestModel.toJson());
        return apiResponse;
  }

  Future<ApiResponse> deleteContact(ContactRequestModel contactRequestModel) async {
    ApiResponse apiResponse = await ApiHelper().makeDeleteRequest("contact/${contactRequestModel.id}");
    return apiResponse;
  }

  
}