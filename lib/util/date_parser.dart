import 'package:intl/intl.dart';

extension DateParser on String? {
  String formatDate({String? oldPattern, required String newPattern, bool? needToLocal}) {
    if (this == null) return "";
    oldPattern ??= 'yyyy-MM-ddTHH:mm:ss.Z';
    try {
      DateTime datetime =
          DateFormat(oldPattern).parse(this!.toUpperCase(), true);
    if(needToLocal ?? false){
      datetime = DateFormat(oldPattern).parse(this!, true).toLocal();
    }
      return DateFormat(newPattern).format(datetime);
    } catch (e) {
      return "";
    }
  }
}
