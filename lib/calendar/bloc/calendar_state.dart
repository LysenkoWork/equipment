part of 'calendar_bloc.dart';

@freezed
class CalendarState with _$CalendarState {

  const factory CalendarState.initial() = _InitialState;

  const factory CalendarState.loading() = _LoadingState;

  const factory CalendarState.addition() = _AdditionState;

  const factory CalendarState.ok() = _OkState;

  const factory CalendarState.error({
    required String error
  }) = _ErrorState;

  const factory CalendarState.data({
    required DateTime date,
    required List<CalendarView>? list
  }) = _DataState;

}  