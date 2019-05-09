import 'package:dart_validator/src/regexs.dart';
import 'package:dart_validator/src/schema.dart';
export 'package:dart_validator/src/schema.dart';

// 成功
typedef _Success = void Function();
// 失败
typedef _Fail = void Function(String message, String key);

class Validator {
  // 规则
  final Map<String, List<Schema>> rules;
  // 验证
  Function() _validate;
  // 数据
  Map<String, dynamic> _data = {};
  // 成功回调
  _Success _success;
  // 失败回调
  _Fail _fail;

  Validator(this.rules) {
    final methods = _beatFlat(rules);
    final list = _stringChain(methods);
    _validate = list[0];
  }

  // 手机
  static bool isPhone(String phone) => RegExp(Regexs.phone).hasMatch(phone);
  // 邮箱
  static bool isEmail(String email) => RegExp(Regexs.email).hasMatch(email);
  // ip
  static bool isIp(String ip) => RegExp(Regexs.ip).hasMatch(ip);
  // url
  static bool isUrl(String url) => RegExp(Regexs.url).hasMatch(url);
  // 数字
  static bool isNumber(String number) => RegExp(Regexs.number).hasMatch(number);

  // 拍平验证函数
  List<Function(Function next)> _beatFlat(Map<String, List<Schema>> rules) {
    final List<Function(Function next)> list = [];

    for (var key in rules.keys) {
      final List<Schema> rules = this.rules[key];

      for (var rule in rules) {
        list.add((next) {
          // value
          final value = _data[key];

          // 判断是否是自定义验证
          if (rule.type != null) {
            bool status = false;
            // 判断类型
            switch (rule.type) {
              case SchemaType.required:
                status = value == null ? false : (value is String && value != '');
                break;
              case SchemaType.phone:
                status = isPhone(value);
                break;
              case SchemaType.email:
                status = isEmail(value);
                break;
              case SchemaType.ip:
                status = isIp(value);
                break;
              case SchemaType.url:
                status = isUrl(value);
                break;
              case SchemaType.number:
                status = isNumber(value);
                break;
            }

            // 判断结果
            if (status) {
              next();
            } else if (_fail != null) {
              _fail(rule.message, key);
            }
          } else {
            // 自定义验证
            rule.validator(key, value, (String message) {
              if (message == null) {
                next();
              } else if (_fail != null) {
                _fail(message, key);
              }
            });
          }
        });
      }
    }

    return list;
  }

  // 串联
  List<Function()> _stringChain(List<Function(Function next)> params) {
    final List<Function()> list = [
      // 最终成功的回调
      () {
        if (_success != null) _success();
      }
    ];

    for (var next in params.reversed) {
      final last = list.last;
      list.add(() {
        next(last);
      });
    }

    return list.reversed.toList();
  }

  // 验证
  validate(Map<String, dynamic> data, { _Fail fail, _Success success }) {
    _data = data;
    _fail = fail;
    _success = success;
    _validate();
  }
}
