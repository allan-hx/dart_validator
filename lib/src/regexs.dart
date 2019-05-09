class Regexs {
  // 手机
  static final String phone = '^((\\+?[0-9]{1,4})|(\\(\\+86\\)))?(13[0-9]|14[57]|15[012356789]|17[03678]|18[0-9])\\d{8}\$';
  // 邮箱
  static final String email = '^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+\$';
  // ip
  static final String ip = '^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])((\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])){3}|(\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])){5})\$';
  // url
  static final String url = '[a-zA-z]+://[^\\s]';
  // 数字
  static final String number = '^[0-9]+\$';
}
