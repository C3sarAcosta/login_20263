import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_20263/providers/login_form_provider.dart';
import 'package:login_20263/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Login authentication flow', () {
    testWidgets('valid email and password should pass the form validation', (tester) async {
      final provider = LoginFormProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: 'usuario@correo.com',
                    onChanged: (value) => provider.email = value,
                    validator: (value) {
                      final pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      final regExp = RegExp(pattern);
                      return regExp.hasMatch(value ?? '') ? null : 'Correo inválido';
                    },
                  ),
                  TextFormField(
                    initialValue: '12345678',
                    onChanged: (value) => provider.password = value,
                    validator: (value) =>
                        (value != null && value.length >= 8) ? null : 'Contraseña inválida',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      provider.email = 'usuario@correo.com';
      provider.password = '12345678';

      expect(provider.isValidForm(), isTrue);
    });

    test('login endpoint should use the API host and path correctly', () {
      final uri = AuthService().loginUri;

      expect(uri.toString(), 'https://receta20263it.somee.com/api/Accounts/login');
    });
  });
}
