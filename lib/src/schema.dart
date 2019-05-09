enum SchemaType {
  // 必填
  required,
  // 手机
  phone,
  // 邮箱
  email,
  // ip
  ip,
  // url
  url,
  // number
  number,
}

class Schema {
  // 类型
  final SchemaType type;
  // 自定义验证
  final void Function(String key, dynamic value, Function(String message) callback) validator;
  // 错误信息
  final String message;

  Schema({
    this.type,
    this.validator,
    this.message,
  }) : assert(type != null || validator != null);
}
