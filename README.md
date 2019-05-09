# dart_validator   [![pub package](https://img.shields.io/badge/-0.0.1-brightgreen.svg)](https://pub.dartlang.org/packages/weui)

#### dart数据校验工具, 适用于表单数据校验, Map数据校验

## 安装
```
dart_validator: 0.0.1
```

## 使用

```dart
// 引入
import 'package:dart_validator/dart_validator.dart';

// 定义规则
final Map<String, List<Schema>> descriptor = {
  'name': [
    Schema(
      type: SchemaType.required,
      message: '名称不能为空',
    ),
  ],
  'age': [
    Schema(
      type: SchemaType.required,
      message: '年龄不能为空',
    ),
  ],
  'sex': [
    Schema(
      type: SchemaType.required,
      message: '性别不能为空',
    ),
  ],
  'phone': [
    Schema(
      type: SchemaType.required,
      message: '手机号不能为空',
    ),
    Schema(
      type: SchemaType.phone,
      message: '手机号格式错误',
    ),
  ],
};

// 实例化
final validator = Validator(descriptor);

// 数据
final data = {
  'name': '123',
  'age': '13',
  'sex': '男',
  'phone': '15818440278',
};

// 调用校验
validator.validate(
  data,
  // 失败
  fail: (message, key) {
    print('$key: $message');
  },
  // 成功
  success: () {
    print('校验成功');
  }
);
```

## 自定义校验和异步校验

```dart
import 'package:dart_validator/dart_validator.dart';

// 定义规则
final Map<String, List<Schema>> descriptor = {
  'name': [
    Schema(
      validator: (key, value, callback) {
        // 定时器模拟请求接口
        Future.delayed(Duration(milliseconds: 2000), () {
          callback(value == '张三' ? '输入的名称不是张三' : null);
        });
      }
    ),
  ],
};


// 实例化
final validator = Validator(descriptor);

// 数据
final data = {
  'name': '李四',
};

// 调用校验
validator.validate(
  data,
  // 失败
  fail: (message, key) {
    print('$key: $message');
  },
  // 成功
  success: () {
    print('校验成功');
  }
);
```
#### `Schema`中的`validator`必须调用`callback`函数, 如果数据校验失败传入提示文字, 成功则传入null