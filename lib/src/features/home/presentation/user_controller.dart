import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/domain/user_model.dart';

final userControllerProvider = StateProvider<User?>((ref) => null);
