abstract class PersonalException {
  factory PersonalException([var message]) => _PersonalException(message);
}

class _PersonalException implements PersonalException {
  final dynamic message;

  _PersonalException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "An error occurred, please retry";
    return message.toString();
  }
}
