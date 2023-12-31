import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/name.dart';
import '../../repository/equipment_repository.dart';

part 'name_bloc.freezed.dart';

part 'name_event.dart';

part 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  EquipmentRepository service;
  bool typeName;

  NameBloc(this.service, this.typeName) : super(const NameState.initial()) {
    on<_InitialEvent>(_onInitialEvent);
    on<_GetListEvent>(_onGetListEvent);
    on<_AddEvent>(_onAddEvent);
  }

  void _onInitialEvent(_InitialEvent event, Emitter<NameState> emit) async {
    await service.getNameList(typeName ? '/view/list' : '/plot/list').then((value) async {
      emit(_DataState(list: value));
    });
  }

  void _onGetListEvent(_GetListEvent event, Emitter<NameState> emit) async {
    await service.getNameList(typeName ? '/view/list' : '/plot/list').then((value) async {
      emit(_DataState(list: value));
    });
  }

  void _onAddEvent(_AddEvent event, Emitter<NameState> emit) async {
    await service.addName(event.value, typeName ? '/view/add' : '/plot/add');
    await service.getNameList(typeName ? '/view/list' : '/plot/list').then((value) async {
      emit(_DataState(list: value));
    });
  }
}

