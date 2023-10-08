import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/models.dart';
import '../../other/other.dart';
import '../service/ppr_service.dart';

part 'ppr_bloc.freezed.dart';

part 'ppr_event.dart';

part 'ppr_state.dart';

class PprBloc extends Bloc<PprEvent, PprState> {
  final PprService service;

  PprBloc(this.service) : super(const PprState.initial('')) {
    on<_InitialEvent>(_onInitialEvent);
    on<_GotoAddPprScreenEvent>(_onGotoAddPprScreenEvent);
    on<_GotoEditPprScreenEvent>(_onGotoEditPprScreenEvent);
    on<_AddPprEvent>(_onAddPprEvent);
    on<_DeletePprEvent>(_onDeletePprEvent);
    on<_UpdatePprEvent>(_onUpdatePprEvent);
    on<_BackEvent>(_onBackEvent);
  }

  void _onInitialEvent(_InitialEvent event, Emitter<PprState> emit) async {
    await service
        .getList(event.pprType, event.equipmentid)
        .then((value) => emit(_DataState(pprType: event.pprType, equipmentid: event.equipmentid, list: value)));
  }

  void _onGotoAddPprScreenEvent(_GotoAddPprScreenEvent event, Emitter<PprState> emit) async {
    emit(_AddScreenState(event.equipmentid));
  }

  void _onGotoEditPprScreenEvent(_GotoEditPprScreenEvent event, Emitter<PprState> emit) {
    emit(_EditScreenState(event.ppr));
  }

  void _onBackEvent(_BackEvent event, Emitter<PprState> emit) async {
    emit(const _BackState());
  }

  void _onAddPprEvent(_AddPprEvent event, Emitter<PprState> emit) async {
    service.addPpr(event.ppr);
    emit(_OkState(pprType: event.pprType, ppr: event.ppr));
  }

  void _onDeletePprEvent(_DeletePprEvent event, Emitter<PprState> emit) async {
    service.deletePpr(event.ppr);
    emit(_OkDeleteState(pprType: event.pprType, ppr: event.ppr));
  }

  void _onUpdatePprEvent(_UpdatePprEvent event, Emitter<PprState> emit) async {
    service.updatePpr(event.ppr);
    emit(_OkState(pprType: event.pprType, ppr: event.ppr));
  }
}
