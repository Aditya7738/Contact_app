part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  @override
  List<Object> get props => [];
}

class ContactCreateLoading extends ContactState{
  @override
  List<Object> get props => [];
}

class ContactCreateSuccess extends ContactState{


  @override
  List<Object> get props => [];
}

class ContactCreateError extends ContactState{
  final String error;
  const ContactCreateError(this.error);

 @override
  List<Object?> get props => [];
}

class ContactReadLoading extends ContactState{
  @override
  List<Object> get props => [];
}

class ContactReadSuccess extends ContactState{
  List<ContactRequestModel> listOfContactRequestModel;

  ContactReadSuccess(this.listOfContactRequestModel);

  @override
  List<Object> get props => [listOfContactRequestModel];
}

class ContactReadError extends ContactState{
  final String error;
  const ContactReadError(this.error);
  @override
  List<Object?> get props => [error];
}

class ContactUpdateLoading extends ContactState{
  @override
  List<Object> get props => [];
}

class ContactUpdateSuccess extends ContactState{

  List<ContactRequestModel> listOfContactRequestModel;

  ContactUpdateSuccess(this.listOfContactRequestModel);

  @override
  List<Object> get props => [listOfContactRequestModel];
}

class ContactUpdateError extends ContactState{
  final String error;
  const ContactUpdateError(this.error);
  @override
  List<Object?> get props => [error];
}

class ContactDeleteLoading extends ContactState{
  @override
  List<Object> get props => [];
}

class ContactDeleteSuccess extends ContactState{

  List<ContactRequestModel> listOfContactRequestModel;

  ContactDeleteSuccess(this.listOfContactRequestModel);

  @override
  List<Object> get props => [listOfContactRequestModel];
}

class ContactDeleteError extends ContactState{
  final String error;
  const ContactDeleteError(this.error);
  @override
  List<Object?> get props => [error];
}

