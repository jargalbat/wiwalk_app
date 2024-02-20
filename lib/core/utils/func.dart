// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'logger.dart';

// import 'package:intl/intl.dart';
// import 'package:mplus/api/api_url.dart';
// import 'package:mplus/app/common/global.dart';
// import 'package:mplus/app/const.dart';
// import 'package:mplus/app/log/logger.dart';
// import 'package:mplus/models/models.dart' as book_model;
// import 'package:mplus/widgets/chips/content_chip.dart';
// import 'package:mplus/widgets/dialogs/custom_dialog.dart';
// import 'package:mplus/widgets/dialogs/dialog_type.dart';
// import 'package:path_provider/path_provider.dart';

class Func {
  // static late Directory _directory;
  //
  // static Directory get appTempDir => _directory;
  //
  // static Future<void> initAppTempDir() async {
  //   try {
  //     // _directory = await getApplicationSupportDirectory();
  //     _directory = await getApplicationDocumentsDirectory();
  //     // if (kDebugMode) {
  //     // print('Support path: ${_directory.path}');
  //     // print('Application Documents Directory: ${_directory.path}');
  //     // }
  //   } catch (e) {
  //     Log().log.wtf(e);
  //   }
  // }

  // static late String _deviceId;
  // static String getDeviceId() => _deviceId;

  // static late bool _jailBroken;
  // static bool isJailBroken() => _jailBroken;

  // static Future<void> unzipFile(File zipFile, String id,
  //     {bool progress = false, bool zipIncludesBaseDirectory = false}) async {
  //   final destinationDir = Directory('${_directory.path}/ebook/$id');
  //   try {
  //     if (destinationDir.existsSync()) {
  //       destinationDir.deleteSync(recursive: true);
  //     }

  //     destinationDir.createSync(
  //       recursive: true,
  //     );
  //     // test concurrent extraction
  //     final extractFutures = <Future>[];
  //     int onExtractingCallCount1 = 0;

  //     extractFutures.add(ZipFile.extractToDirectory(
  //         zipFile: zipFile,
  //         destinationDir: destinationDir,
  //         onExtracting: progress
  //             ? (zipEntry, progress) {
  //                 ++onExtractingCallCount1;
  //                 return ZipFileOperation.includeItem;
  //               }
  //             : null));

  //     await Future.wait<void>(extractFutures);
  //     assert(!progress || onExtractingCallCount1 > 0);
  //   } catch (e) {
  //     destinationDir.deleteSync(recursive: true);
  //     Log().log.wtf(e);
  //   }
  // }

//   static String? getDownloadedAudioTrackPath({
//     required CAudioType audioType,
//     required String albumId,
//     String? trackId,
//     String? extension,
//   }) {
//     try {
//       String? path = getAudioTrackFileKey(
//         audioType: audioType,
//         albumId,
//         trackId ?? 'track',
//         extension ?? 'mp3',
//         saveType: SaveType.store,
//       );
//
//       File file = File(path);
//       bool fileExists = file.existsSync();
//       if (fileExists) {
//         return path;
//       }
//     } catch (ex) {
//       Log().log.wtf(ex);
//     }
//
//     return null;
//   }
//
//   static bool podcastExists(
//       String channelId,
//       String episodeId,
//       String extension,
//       ) {
//     try {
//       File file = File(
//         getAudioTrackFileKey(
//           channelId,
//           episodeId,
//           extension,
//           audioType: CAudioType.podcast,
//           saveType: SaveType.store,
//         ),
//       );
//       return file.existsSync();
//     } catch (ex) {
//       Log().log.wtf(ex);
//       return false;
//     }
//   }
//
//   static void deletePodcast(
//       String channelId, String episodeId, String extension) {
//     try {
//       File file = File(
//         getAudioTrackFileKey(
//           channelId,
//           episodeId,
//           extension,
//           audioType: CAudioType.podcast,
//           saveType: SaveType.store,
//         ),
//       );
//       if (file.existsSync()) {
//         file.deleteSync(recursive: true);
//       }
//     } catch (ex) {
//       Log().log.wtf(ex);
//     }
//   }
//
//   static String getAudioBookPathKey(
//       String bookId, {
//         CAudioType audioType = CAudioType.audiobook,
//         SaveType saveType = SaveType.download,
//       }) =>
//       <String>{
//         _directory.path,
//         audioTypeToStr(audioType),
//         saveType == SaveType.download ? 'download' : 'data',
//         bookId
//       }.join(Platform.pathSeparator);
//
//   static String getAudioTrackPathKey(
//       String bookId,
//       String chapterId, {
//         CAudioType audioType = CAudioType.audiobook,
//         SaveType saveType = SaveType.download,
//       }) =>
//       <String>{
//         _directory.path,
//         audioTypeToStr(audioType),
//         saveType == SaveType.download ? 'download' : 'data',
//         bookId,
//         chapterId
//       }.join(Platform.pathSeparator);
//
//   static String getAudioTrackFileKey(
//       String albumId,
//       String trackId,
//       String extension, {
//         CAudioType audioType = CAudioType.audiobook,
//         SaveType saveType = SaveType.download,
//       }) {
//     return <String>{
//       getAudioTrackPathKey(
//         albumId,
//         trackId,
//         audioType: audioType,
//         saveType: saveType,
//       ),
//       '$trackId.$extension'
//     }.join(Platform.pathSeparator);
//   }
//
//   static String generateRandomString(int len) {
//     final r = Random();
//     const _chars =
//         'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//     return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
//         .join();
//   }
//
//   static double ratio(String? url) {
//     try {
//       if (url == null || url.isEmpty) return 1;
//       final exp = RegExp(r"(?<=_)(.{1,5})(?=.jpg)");
//       final match = exp.firstMatch(url);
//       final matchedText = match?.group(0);
//
//       var res = double.tryParse(matchedText.toString()) ?? 1;
//       // debugPrint(res.toString());
//       return res;
//     } catch (ex) {
//       Log().log.wtf(ex);
//       return 1;
//     }
//   }
//
//   static double ratioHeight(String url, double width) {
//     return (1 / ratio(url)) * width;
//   }
//
//   static Future<Map<String, dynamic>> parseJsonFromAssets(
//       String assetsPath) async {
//     return rootBundle
//         .loadString(assetsPath)
//         .then((jsonStr) => jsonDecode(jsonStr));
//   }
//
//   static Future<dynamic> uploadAnalyticsLog(
//       {Map<String, dynamic>? logData}) async {
//     try {
//       Map<String, dynamic>? data = logData;
//       final _directory = await getTemporaryDirectory();
//       final String path =
//       <String>{_directory.path, 'events.txt'}.join(Platform.pathSeparator);
//       File logFile = File(path);
//       if (!logFile.existsSync()) {
//         logFile.createSync();
//       }
//
//       if (data != null &&
//           data.isNotEmpty &&
//           Functions.isNotEmpty(DeviceInfo().sessionId) &&
//           Functions.isNotEmpty(Global.userInfo?.id)) {
//         data['t'] = DateTime.now().millisecondsSinceEpoch / 1000;
//         data['s'] = DeviceInfo().sessionId;
//         data['did'] = Global.appInit?.data?.deviceId;
//         data['d'] = DeviceInfo().deviceId;
//         data['u'] = Global.userInfo?.id;
//
//         String newLog = jsonEncode(data);
//
//         logFile.writeAsStringSync('$newLog\n', mode: FileMode.append);
//       }
//
//       final fileContent = logFile.readAsStringSync();
//       final newLines = fileContent.split('\n');
//
//       if (newLines.length >= 20) {
//         final response = await AnalyticsAPI.uploadAnalictsEvent(logFile);
//         if ((response.statusCode ?? 0) >= 200 &&
//             (response.statusCode ?? 0) <= 299) {
//           logFile.writeAsStringSync('');
//         } else {
//           Log().log.e(response.statusMessage);
//         }
//       }
//     } catch (ex) {
//       Log().log.wtf(ex);
//     }
//   }
//
  static bool isLatinScript(String? value) {
    if (value != null && value.isNotEmpty) {
      return RegExp(r'^[a-z]+$').hasMatch(value);
    }
    return false;
  }

  static String format(int? n) {
    if (n == null) return '0.00';
    return n.toStringAsFixed(2).endsWith('.00')
        ? n.toStringAsFixed(0)
        : n.toStringAsFixed(2);
  }

  static String toAmount(Object? value, {NumberFormat? numberFormat}) {
    //Хоосон утгатай эсэх
    if (toStr(value) == "") {
      return "0.00";
    }

    //Зөвхөн тоо агуулсан эсэх
    String tmpStr = toStr(value).replaceAll(",", "").replaceAll(".", "");
    if (!isNumeric(tmpStr)) {
      return "0.00";
    }

    //Хэрэв ',' тэмдэгт агуулсан бол устгана
    double tmpDouble = double.parse(toStr(value).replaceAll(",", ""));

    String result = "";
    try {
      //Format number
      NumberFormat formatter = numberFormat ?? NumberFormat("#,###.##");
      result = formatter.format(tmpDouble);
    } catch (e) {
      result = "0.00";
    }

    return result;
  }

  static bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static bool isEmpty(Object? o) => o == null || o == '';

  static bool isNotEmpty(Object? o) => o != null && o != '';

  static String toStr(Object? obj) {
    String res = '';
    try {
      if (obj == null) {
        res = '';
      } else if (obj is DateTime) {
        res = DateFormat('yyyy-MM-dd').format(obj); //'yyyy-MM-dd HH:mm:ss'
      } else if (obj is int) {
        res = obj.toString();
      } else if (obj is double) {
        res = obj.toString();
      } else if (obj is String) {
        res = obj;
      }
    } catch (e) {
      logger.f(e);
    }
    return res;
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static int toInt(Object? obj) {
    int res = 0;

    try {
      if (obj == null) {
      } else if (obj is int) {
        res = obj;
      } else if (obj is double) {
        res = obj.toInt();
      } else if (obj is String) {
        obj = obj.replaceAll(',', '');
        if (obj.contains('.')) {
          res = double.parse(obj).toInt();
        } else {
          res = int.parse(obj);
        }
      }
    } catch (e) {
      // Log().log.d(e); //todo
    }

    return res;
  }

  static double toDouble(Object? obj) {
    double res = 0.0;
    try {
      if (obj == null) {
        // nothing
      } else if (obj is int) {
        res = obj.toDouble();
      } else if (obj is double) {
        res = obj;
      } else if (obj is String) {
        res = double.parse(obj.replaceAll(',', ''));
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

//   static bool isNullEmpty(String? value) => value == null || value.isEmpty;
//
//   static bool isNotNullEmpty(String? value) => !isNullEmpty(value);
//
//   static String formatDateStr(String? str) {
//     if (isEmpty(str)) return '';
//     DateTime dateTime = DateTime.parse(str!);
//     String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
//     return formattedDate;
//   }
//
//   static String formatTimeStr(String? str) {
//     if (isEmpty(str)) return '';
//     DateTime dateTime = DateTime.parse(str!);
//     String formattedDate = DateFormat('HH:mm:ss').format(dateTime);
//     return formattedDate;
//   }
//
//   static String formatDateTimeStr(String? str) {
//     // Datetime string-ийг форматлаад буцаана '2019.01.01T15:13:00.000' to '2019.01.01 15:13:00'
//     if (isEmpty(str)) return '';
//
//     DateTime dateTime = DateTime.parse(str!);
//     String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
//
//     return formattedDate; //trim(str.split(" ")[0]);
//   }
//
//   /// Datetime string-ийг ISO8601 руу хөрвүүлнэ
//   static String? formatDateTimeStrToIso8601(String? str) {
//     try {
//       if (isEmpty(str)) return null;
//
//       DateTime dateTime = DateTime.parse(str!);
//
//       return dateTime.toUtc().toIso8601String();
//     } catch (ex) {
//       Log().log.wtf(ex);
//       return null;
//     }
//   }
//
//   static String toDateTimeStr(DateTime? dateTime, {String? dateFormat}) {
//     if (dateTime == null) return '';
//
//     var res = '';
//     res = DateFormat(dateFormat ?? 'yyyy-MM-dd').format(dateTime);
//
//     return res;
//   }
//
//   static String? primaryHexColorFromUrl(String? url) {
//     if (url == null || url.isEmpty) return null;
//     var re = RegExp(r'(?<=_)([a-zA-Z0-9]{6})(?=_)');
//     var match = re.firstMatch(url);
//     if (match != null) return (match.group(0));
//     return null;
//   }
//
//   static DateTime? toDate(String? str) {
//     try {
//       return Functions.isNotEmpty(str) ? DateTime.parse(str!) : null;
//     } catch (e) {
//       Log().log.wtf(e);
//     }
//
//     return null;
//   }
//
//   static bool isVersionGreaterThan(String currentVersion, String newVersion) {
//     bool res = false;
//     try {
//       List<String> currentV = currentVersion.split(".");
//       List<String> newV = newVersion.split(".");
//       for (var i = 0; i <= 2; i++) {
//         res = int.parse(newV[i]) > int.parse(currentV[i]);
//         if (int.parse(newV[i]) != int.parse(currentV[i])) break;
//       }
//     } catch (e) {
//       Log().log.wtf(e);
//     }
//
//     return res;
//   }
//
//   static bool checkExpired({
//     String? expireDate,
//   }) {
//     try {
//       if (expireDate == null) return false;
//       final unlockDate = DateTime.parse(expireDate).toLocal();
//       final now = DateTime.now().toLocal();
//       if (now.compareTo(unlockDate) > 0 || now.compareTo(unlockDate) == 0) {
//         return true;
//       }
//       return false;
//     } catch (ex) {
//       Log().log.wtf(ex);
//       return false;
//     }
//   }
//
//   static String getLocalDateTimeinTimeZone({int hours = 0}) {
//     final now =
//     DateTime.now().toUtc().add(Duration(hours: hours)).toIso8601String();
//     return now;
//   }
//
//   static ChipSettings? getType(String? typeString) {
//     if ((typeString ?? '').isEmpty) return null;
//     switch (typeString!.toLowerCase()) {
//       case 'ebook':
//         return ChipSettings.eBook;
//       case 'audiobook':
//       case 'audio_book':
//         return ChipSettings.audioBook;
//       case 'summary':
//       case 'esummary':
//         return ChipSettings.summary;
//       case 'renting':
//       case 'rental':
//         return ChipSettings.rental;
//       case 'podcasts':
//       case 'podcast':
//         return ChipSettings.podcast;
//       case 'author':
//         return ChipSettings.author;
//       case 'channel':
//         return ChipSettings.channel;
//       case 'episode':
//         return ChipSettings.episode;
//       case 'audio_summary':
//       default:
//         return null;
//     }
//   }
//
//   static String? toSemantics(String? text) {
//     return text?.toLowerCase().replaceAll('ү', 'у');
//   }
//
//   static bool isAdultContent({
//     required book_model.Book book,
//     int ageLimit = 18,
//   }) {
//     try {
//       if (book.metadata == null || book.metadata!.isEmpty) {
//         return false;
//       }
//       final String value = book.metadata?.first.data
//           ?.firstWhere(
//             (element) =>
//         (element.label ?? '').toLowerCase() == 'насны ангилал',
//         orElse: () => book_model.MetaData(
//           label: null,
//           value: null,
//         ),
//       )
//           .value ??
//           '';
//       final current = Functions.toInt(value.replaceAll('+', ''));
//       if (current >= ageLimit) {
//         return true;
//       }
//       return false;
//     } catch (ex) {
//       Log().log.wtf(ex);
//       return false;
//     }
//   }
//
//   static bool shouldWarnAdultBook({
//     required book_model.Book book,
//     required String type,
//     int ageLimit = 18,
//   }) {
//     try {
//       if (!isAdultContent(book: book, ageLimit: ageLimit)) {
//         return false;
//       }
//
//       if ((Global.shPrefs.getString(
//           SpKeys.adultContentWarningShownKey('${book.id}_$type')) ??
//           '')
//           .isNotEmpty) {
//         return false;
//       }
//
//       return true;
//     } catch (ex) {
//       Log().log.wtf(ex);
//       return false;
//     }
//   }
//
//   static void showAdultWarning({
//     required BuildContext context,
//     required book_model.Book book,
//     required String type,
//     required VoidCallback? onContinue,
//     int ageLimit = 18,
//     VoidCallback? onCancel,
//   }) {
//     try {
//       if (Functions.shouldWarnAdultBook(
//         book: book,
//         ageLimit: ageLimit,
//         type: type,
//       )) {
//         showCustomDialog(
//           context,
//           dialogType: DialogType.warning,
//           assetColor: Colors.white,
//           text:
//           'Уг бүтээл нь насанд хүрэгчдэд зориулсан агуулгатай тул та 18с дээш настай бол Үргэлжлүүлэх товч дарна уу',
//           button1Text: 'Үгүй',
//           button2Text: 'Үргэлжлүүлэх',
//           onPressedButton1: () {
//             onCancel?.call();
//           },
//           onPressedButton2: () {
//             Global.shPrefs.setString(
//                 SpKeys.adultContentWarningShownKey('${book.id}_$type'), 'true');
//             onContinue?.call();
//           },
//         );
//       } else {
//         onContinue?.call();
//       }
//     } catch (ex) {
//       Log().log.wtf(ex);
//       onContinue?.call();
//     }
//   }
//
//   static String? backgroundColorCode(String? imageUrl) {
//     if (imageUrl != null) {
//       var re = RegExp(r'(?<=_)(.*)(?=_)');
//       var match = re.firstMatch(imageUrl);
//       if (match != null) return (match.group(0));
//     }
//
//     return null;
//   }

  static bool hasMinimumLength(String password) {
    try {
      final regex = RegExp(r"^.{8,}$");
      return regex.hasMatch(password);
    } catch (e) {
      return false;
    }
  }

  static bool hasUppercaseLetter(String password) {
    try {
      final regex = RegExp(r".*[A-Z].*");
      return regex.hasMatch(password);
    } catch (e) {
      return false;
    }
  }

  static bool hasLowercaseLetter(String password) {
    try {
      final regex = RegExp(r".*[a-z].*");
      return regex.hasMatch(password);
    } catch (e) {
      return false;
    }
  }

  static bool isValidEmail(String email) {
    try {
      final regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
      );
      return regex.hasMatch(email);
    } catch (e) {
      return false;
    }
  }

  static bool isEightDigits(String number) {
    try {
      final regex = RegExp(r"^\d{8}$");
      return regex.hasMatch(number);
    } catch (e) {
      return false;
    }
  }
}
