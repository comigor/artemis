import 'package:intl/intl.dart';

final dateFormatter = DateFormat('yyyy-MM-dd');
final timeFormatter = DateFormat('HH:mm:ss');

DateTime fromGraphQLDateToDartDateTime(String date) => DateTime.parse(date);
String fromDartDateTimeToGraphQLDate(DateTime date) =>
    dateFormatter.format(date);
DateTime fromGraphQLTimeToDartDateTime(String time) =>
    DateTime.parse('1970-01-01T${time}Z');
String fromDartDateTimeToGraphQLTime(DateTime date) =>
    timeFormatter.format(date);
DateTime fromGraphQLDateTimeToDartDateTime(String date) => DateTime.parse(date);
String fromDartDateTimeToGraphQLDateTime(DateTime date) =>
    date.toIso8601String();

List<DateTime> fromGraphQLDateListToDartDateTimeList(List<String> date) =>
    date.map(fromGraphQLDateToDartDateTime).toList();
List<String> fromDartDateTimeListToGraphQLDateList(List<DateTime> date) =>
    date.map(fromDartDateTimeToGraphQLDate).toList();
