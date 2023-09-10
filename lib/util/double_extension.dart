
import 'package:intl/intl.dart';

extension DoubleExtenstion on double? {
  String priceFormat({String currency = "Rp"}) {
    if (this == null) return "${currency}0";

    final formatter = NumberFormat("#,##0", "id_ID");
    return currency + formatter.format(this!).toString();
  }
}
