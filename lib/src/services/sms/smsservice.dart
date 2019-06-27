import 'package:sms_maintained/sms.dart';


class SmsService {

  static Future<List<SmsMessage>> getAllSmsMessages() {
    SmsQuery _smsQuery = SmsQuery();
    return _smsQuery.getAllSms;
  }
}