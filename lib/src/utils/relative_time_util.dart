import 'package:intl/intl.dart';

class RelativeTimeUtil {
  
  static String getRelativeTime(int timestamp) {
    var now = DateTime.now();
    // var format = DateFormat('dd-MM-yyyy HH:mm a');
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time =  'Hace ' + diff.inDays.toString() + ' dia';
      } else {
        time = 'Hace ' + diff.inDays.toString() + ' dias';
      }
    } else {
      if (diff.inDays == 7) {
        time = 'Hace ' + (diff.inDays / 7).floor().toString() + ' semana';
      } else {

        time = 'Hace ' + (diff.inDays / 7).floor().toString() + ' semanas';
      }
    }
    return time;
  }

}