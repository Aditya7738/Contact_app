import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:contact_app/src/controller/contact_cubit/contact_repository.dart';
import 'package:contact_app/src/core/constants/strings.dart';
import 'package:contact_app/src/core/network/api_response.dart';
import 'package:contact_app/src/models/contactRequestModel.dart';
import 'package:equatable/equatable.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  //get data for repository
  createContact(ContactRequestModel contactRequestModel) async {
    emit(ContactCreateLoading());
    try {
      ContactRepository contactRepository = ContactRepository();
      ApiResponse apiResponse =
          await contactRepository.createNewContact(contactRequestModel);

      if (apiResponse.status == true) {
        emit(ContactCreateSuccess());
      } else {
        emit(ContactCreateError(apiResponse.error!));
      }
    } catch (e) {
      emit(const ContactCreateError(Strings.apiResonseError));
    }
  }

  Future<void> readContact() async {
    try {
      ContactRepository contactRepository = ContactRepository();
      ApiResponse apiResponse = await contactRepository.getAllContact();
      if (apiResponse.status == true) {

        List<dynamic> dataRaw = apiResponse.data;
        List<ContactRequestModel> listOfContactModel = dataRaw.map((element) => ContactRequestModel.fromJson(element)).toList();
        emit(ContactReadSuccess(listOfContactModel));
      } else {
        emit(ContactCreateError(apiResponse.error!));
      }
    } catch (e) {
      emit(ContactReadError(e.toString()));
    }
  }

  updateContact(ContactRequestModel contactRequestModel) async {
    try {
      ContactRepository contactRepository = ContactRepository();
      ApiResponse apiResponse =
          await contactRepository.updateContact(contactRequestModel);

      if (apiResponse.status == true) {

        List<dynamic> listOfMap = apiResponse.data;
        List<ContactRequestModel> listOfContactRequestModel = listOfMap.map((map) => ContactRequestModel.fromJson(map)).toList();

        emit(ContactUpdateSuccess(listOfContactRequestModel));
      } else {
        emit(ContactUpdateError(apiResponse.error!));
      }
    } catch (e) {
      emit(ContactUpdateError(e.toString()));
    }
  }

  deleteContact(ContactRequestModel contactRequestModel) async {
    try {
      ContactRepository contactRepository = ContactRepository();
      ApiResponse apiResponse =
          await contactRepository.deleteContact(contactRequestModel);

      if (apiResponse.status == true) {
        List<dynamic> listOfMap=apiResponse.data;
        List<ContactRequestModel> listOfContactRequestModel = listOfMap.map((map) => ContactRequestModel.fromJson(map)).toList();

        emit(ContactDeleteSuccess(listOfContactRequestModel));
      } else {
        emit(ContactDeleteError(apiResponse.error!));
      }
    } catch (e) {
      emit(ContactDeleteError(e.toString()));
    }
  }
}
