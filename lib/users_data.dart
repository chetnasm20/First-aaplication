import 'package:careercounselling/models/feedback_form.dart';
import 'package:flutter/physics.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi{
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets111",
  "private_key_id": "446ac12ece0c3f59de34bf5757fda28c7e5e49b9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC13X30xxF3Lrx5\nOwt+IIzTc437tZkxTjO/uSrYXzQW/jMpWjQ55G6QX0eFZqhg0kXGH2UJCNGlk9aU\nKhd5PuekGYWglrGnBw3OOy2YHN3yr+70wACRzsBNFUrZhBcc5+7LE6bN8sT6uLc/\nKxZLlHeTg6rmdOlC3BJFF8VXjiGEYXB43XeMZYoGU9i8CYmJTThXfzULMv3rhUEe\n9zCd1NpoBHjEfYjahdd5QJn4tyf6nRyX9Gf0cGlitYPPBdmP7AIx8/84ezD/n5SO\ngCm81Ot+ysISVE7HO/Wu9GTsO5Vro2rwNDjf+afJ4L3r6lljFENxpR78ZJFT/HJq\nFjZg0X5tAgMBAAECggEAEJtjs5T0BtaZNlbKc1+EjJCKQBhynzp9Zj4B6BU1e/4F\nbPrENx8ha4SP0uIvcPvyjCd0wfDwt/Z6izgWwacZXvZHqgTovxBZVeI4hSHpsI4Z\nO3dG9gmTrNZLafZyZ9zUBO5L9pV7IEv6y8Vi+U7a5nkJA5dcb5MKBg4oIpkjfWOC\n2ss9ZH3I9e56LZJo7Tcl2f4iG7SfwrHAWi6JPvD6P42KGNrbuTFGIt7W2cpXdhbw\nHl2NPGlJw+0tIrvE0GR9MkWEHoVnb11t/F0hl8oITGC2iJ/zbZnINAN3WnvRCBPM\nHLvKpIfns+upgmO2t2GdM/MGGy5NB6V0yhA+MoY3fwKBgQDtsjtBrn1nBC84O/6Z\n+kQaCHsnGiBQhyKGBc87ufyKl8bMURf4wuHkj4ns76RihGASAXKGGS+uh6MnTU8H\naXuFmlMAqMEe7FEC+1K13mq3+x7tYdDQgH/fwewl0+XsYrwN6HSY/bShY/yuG+km\n5xI/HQvRB9DSH2SiuIIk4+KEiwKBgQDD3qYjUCK43nK7v0N8vUvDKnag+Ua3mi1t\nsiHMvp6IeHMo+snURujI4NElQVEsJsNEaODSZOMrLe8A3EcKx705oocpYTogPppr\nQWHxKqNu74iLHqTmZMxOfG95NcIOl6Mas/PA+sdmWsvEb9p6tahJxshmWdsnhRQw\nThlD6S9P5wKBgB2gzsQUJOt3WQ9wYv78dAqurfMkzYxcG9CK3tb6CuGXo58KKKvI\nVvHvdmjDQkFJcNQtvAG9F/VwUMTwXP52hoATyW7WmiPpnvt5KkkjLTg7pBJA1A95\nRPc2K+JXNFyvvfMZ25bKYP6RAQkOz5Qaz2pwi22FxOC8KwYha49/nFebAoGAN9Qm\nlrooq3j8SvdhTRTHm4Fm/ssOlRalDDdR2wIaPdvXNz8EeDUd9OPfuTa85FDIJ5+d\nNVr8RTp6fUxME46LKPpifDDyWG5/pUKloA//NYeg68Z4ShNBCL3/KBVikrY2D05r\nk/3nCA2pNvyK0Z8lsKGwTTwfc0xDTOF14h19FtECgYEArqhHUNEEn5ZlOR64Qizk\nMH818S+pWJy8rICzWFkQIEOdczO4jEmjVEfLqxnyKeK4nfIK5t8PwjeELDybdX4A\n1LTHj0iSN+2zpn5TAXDLTtjRR9hjsKtbzMVDiDKjZJvhKtDgYf7nIPO67bF4CurY\nw0OkIQbTYb8kagiqr9PYJqQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets111@gsheets111.iam.gserviceaccount.com",
  "client_id": "110334835938981575063",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets111%40gsheets111.iam.gserviceaccount.com"
}
  ''';
  static final _spreadsheetId = '1nur48CIrgflsJgMo0c7kudBA4rL08EvKonv3Ndiw1cM';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    }catch(e){
      print("Init Error : $e");
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet,{
        required String title,
})async{
    try {
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async{
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<User?> getById(int id) async{
    if  (_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future insert (List<Map<String,dynamic>>rowList)async{
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}