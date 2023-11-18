import 'package:contact_app/src/controller/records_cubit/records_repository.dart';
import 'package:contact_app/src/models/record.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'records_state.dart';

class RecordsCubit extends Cubit<RecordsState> {

  //design UI

  RecordsCubit() : super(RecordsInitial());

  getRecordData() async {
    emit(RecordsLoading());
    RecordsRepository recordsRepository = RecordsRepository();
    List<dynamic>? data = await recordsRepository.getData();

    if(data == null){
      emit(RecordsError());
      return;
    }

    List<Records> records = data.map((item) => Records.fromJSON(item)).toList();

    emit(RecordsSuccess(records: records));

  }
}
