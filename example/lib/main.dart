import 'package:flutter/material.dart';
import 'package:dart_validator/dart_validator.dart';

void main() => runApp(MyApp());

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
    Schema(
      validator: (key, value, callback) {
        callback(value < 18 ? '未成年不能通过' : null);
      }
    )
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

final validator = Validator(descriptor);
final data = {
  'name': '123',
  'age': 13,
  'sex': '男',
  'phone': '15818440278',
};

class MyApp extends StatelessWidget {
  MyApp() {
    validator.validate(
      data,
      fail: (message, key) {
        print('$key: $message');
      },
      success: () {
        print('校验成功');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'validator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('validator'),
        ),
        body: Center(
          child: MaterialButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () {
            },
            child: Text('验证'),
          ),
        ),
      ),
    );
  }
}
