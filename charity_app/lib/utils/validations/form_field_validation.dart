import 'package:form_field_validator/form_field_validator.dart';

// GLOBALLY - SETTER - FOR - REQUIRED - FIELDS

final requiredValidator =
    RequiredValidator(errorText: 'this field is required');

// MULTI - VALIDATORS - ( PASSWORD || REQUIRD || MAX LENGTH || IS IT STRONG )

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);
// MULTI - VALIDATOR - EMAIL - VALIDATION
final emailValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ],
);
