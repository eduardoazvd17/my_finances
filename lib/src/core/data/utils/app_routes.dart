import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/features/authentication/presentation/pages/login_page.dart';
import 'package:myfinances/src/features/authentication/presentation/pages/register_page.dart';
import 'package:myfinances/src/features/authentication/presentation/pages/welcome_page.dart';
import 'package:myfinances/src/features/documents/data/bindings/document_editor_binding.dart';
import 'package:myfinances/src/features/documents/presentation/pages/document_editor_page.dart';
import 'package:myfinances/src/features/documents/presentation/pages/documents_page.dart';

import '../../../features/authentication/data/bindings/auth_binding.dart';
import '../../../features/documents/data/bindings/documents_binding.dart';
import '../../../features/documents/data/models/document_model.dart';
import '../../../features/documents/presentation/pages/add_document_page.dart';
import '../middlewares/auth_middleware.dart';

class AppRoutes {
  static const String _welcome = "/welcome";
  static const String _login = "/login";
  static const String _register = "/register";
  static const String _documents = "/documents";
  static const String _addDocument = "$_documents/addDocument";
  static const String _documentEditor = "$_documents/editor";

  static String get initialRoute => _welcome;

  static void goToWelcomePage() => _navigate(_welcome, offAll: true);
  static void goToLoginPage() => _navigate(_login);
  static void goToRegisterPage() => _navigate(_register);
  static void goToDocumentsPage() => _navigate(_documents, offAll: true);
  static void goToAddDocumentPage() => _navigate(_addDocument);
  static void goToDocumentEditorPage({
    required DocumentModel documentModel,
  }) {
    _navigate(
      _documentEditor,
      arguments: documentModel,
    );
  }

  static List<GetPage> getGetPages() {
    return [
      GetPage(
        name: _welcome,
        page: () => const WelcomePage(),
        binding: AuthBinding(),
        transition: _getTransition(_welcome),
      ),
      GetPage(
        name: _login,
        page: () => const LoginPage(),
        binding: AuthBinding(),
        transition: _getTransition(_login),
      ),
      GetPage(
        name: _register,
        page: () => const RegisterPage(),
        binding: AuthBinding(),
        transition: _getTransition(_register),
      ),
      GetPage(
        name: _documents,
        page: () => const DocumentsPage(),
        binding: DocumentsBinding(),
        transition: _getTransition(_documents),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: _addDocument,
        page: () => const AddDocumentPage(),
        binding: DocumentsBinding(),
        transition: _getTransition(_addDocument),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: _documentEditor,
        page: () => const DocumentEditorPage(),
        binding: DocumentEditorBinding(),
        transition: _getTransition(_documentEditor),
        middlewares: [AuthMiddleware()],
      ),
    ];
  }

  static Future<T?> _navigate<T>(
    String route, {
    bool offAll = false,
    Map<String, String>? parameters,
    dynamic arguments,
  }) async {
    if (offAll) {
      return await Get.offAllNamed<T>(
        route,
        parameters: parameters,
        arguments: arguments,
      );
    } else {
      return await Get.toNamed<T>(
        route,
        parameters: parameters,
        arguments: arguments,
      );
    }
  }

  static Transition _getTransition(String route) {
    if (kIsWeb || route == _documentEditor) {
      return Transition.downToUp;
    } else {
      return Transition.cupertino;
    }
  }
}
