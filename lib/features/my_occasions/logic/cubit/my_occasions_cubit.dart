import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/my_occasions_response.dart';
import '../../data/repos/my_occasions_repo.dart';
import 'my_occasions_state.dart';

class MyOccasionsCubit extends Cubit<MyOccasionsState> {
  final MyOccasionsRepo _myOccasionsRepo;

  MyOccasionsCubit(this._myOccasionsRepo)
      : super(const MyOccasionsState.initial());

  Future<void> getMyOccasions() async {
    emit(const MyOccasionsState.loading());
    try {
      final response = await _myOccasionsRepo.getMyOccasions();
      response.when(
        success: (List<MyOccasionItem> data) {
          log('Successfully received My Occasions data with ${data.length} items');

          // Sort occasions by date
          final sortedData = _sortOccasionsByDate(data);

          emit(MyOccasionsState.success(sortedData));
        },
        failure: (error) {
          log('Error fetching My Occasions data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(MyOccasionsState.error(
              error.message ?? 'Failed to fetch My Occasions data'));
        },
      );
    } catch (e, stackTrace) {
      log('My Occasions unexpected error: $e', stackTrace: stackTrace);
      emit(MyOccasionsState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Sorts occasions by date with upcoming ones first
  /// - First upcoming occasions (from closest to furthest)
  /// - Then past occasions (from most recent to oldest)
  List<MyOccasionItem> _sortOccasionsByDate(List<MyOccasionItem> occasions) {
    final now = DateTime.now();
    final upcoming = <MyOccasionItem>[];
    final past = <MyOccasionItem>[];

    // Separate upcoming and past occasions
    for (final occasion in occasions) {
      if (occasion.date.isAfter(now) || _isSameDay(occasion.date, now)) {
        upcoming.add(occasion);
      } else {
        past.add(occasion);
      }
    }

    // Sort upcoming occasions by date (closest first)
    upcoming.sort((a, b) => a.date.compareTo(b.date));

    // Sort past occasions by date (most recent first)
    past.sort((a, b) => b.date.compareTo(a.date));

    // Combine the lists with upcoming first
    return [...upcoming, ...past];
  }

  /// Checks if two dates are the same day, ignoring time
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> createOccasion(String name, DateTime date) async {
    emit(const MyOccasionsState.actionLoading());
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      final response = await _myOccasionsRepo.createOccasions({
        'name': name,
        'date': formattedDate,
      });

      response.when(
        success: (data) {
          log('Successfully created occasion: ${data.message}');
          emit(MyOccasionsState.actionSuccess(
            'Occasion created successfully',
            occasion: data.userOccasion,
          ));

          // Refresh occasions list after successful creation
          getMyOccasions();
        },
        failure: (error) {
          log('Error creating occasion: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(MyOccasionsState.actionError(
            error.message ?? 'Failed to create occasion',
          ));
        },
      );
    } catch (e, stackTrace) {
      log('Create occasion unexpected error: $e', stackTrace: stackTrace);
      emit(MyOccasionsState.actionError(
        'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  Future<void> updateOccasion(String id, String name, DateTime date) async {
    emit(const MyOccasionsState.actionLoading());
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      final response = await _myOccasionsRepo.updateOccasion(id, {
        'name': name,
        'date': formattedDate,
      });

      response.when(
        success: (data) {
          log('Successfully updated occasion: ${data.message}');
          emit(MyOccasionsState.actionSuccess(
            'Occasion updated successfully',
            occasion: data.userOccasion,
          ));

          // Refresh occasions list after successful update
          getMyOccasions();
        },
        failure: (error) {
          log('Error updating occasion: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(MyOccasionsState.actionError(
            error.message ?? 'Failed to update occasion',
          ));
        },
      );
    } catch (e, stackTrace) {
      log('Update occasion unexpected error: $e', stackTrace: stackTrace);
      emit(MyOccasionsState.actionError(
        'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  Future<void> deleteOccasion(String id) async {
    emit(const MyOccasionsState.actionLoading());
    try {
      final response = await _myOccasionsRepo.deleteOccasion(id);

      response.when(
        success: (data) {
          log('Successfully deleted occasion: ${data["message"]}');
          emit(const MyOccasionsState.actionSuccess(
            'Occasion deleted successfully',
          ));

          // Refresh occasions list after successful delete
          getMyOccasions();
        },
        failure: (error) {
          log('Error deleting occasion: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(MyOccasionsState.actionError(
            error.message ?? 'Failed to delete occasion',
          ));
        },
      );
    } catch (e, stackTrace) {
      log('Delete occasion unexpected error: $e', stackTrace: stackTrace);
      emit(MyOccasionsState.actionError(
        'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }
}
