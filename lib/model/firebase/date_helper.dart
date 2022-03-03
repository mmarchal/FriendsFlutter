import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateHelper {
  String getDate(String timestamp) {
    initializeDateFormatting();
    DateTime now = DateTime.now();
    DateTime datePost =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(timestamp)!);
    DateFormat format;

    if (now.difference(datePost).inDays > 0) {
      format = DateFormat.yMMMd("fr_FR");
    } else {
      format = DateFormat.Hm("fr_FR");
    }

    return format.format(datePost).toString();
  }
}
