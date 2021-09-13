import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Fun {
  //openLink function to open news in browser
  static Future<void> openLink(String link) async {
    var urlLink = link;
    if (await canLaunch(urlLink)) {
      await launch(urlLink);
    } else {
      await launch(urlLink);
    }
  }

  //shareLink function to share news
  static Future<void> shareLink(String link) async {
    Share.share(link);
  }

  //copyLink function to copy link of news
  static Future<void> copyLink(String link) async {
    FlutterClipboard.copy(link).then(( value ) => print('copied'));

  }

}