import 'package:flutter/material.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';

import '../../../../core/presentation/widgets/text_field_widget.dart';

class AddDocumentPage extends StatelessWidget {
  const AddDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Novo documento'),
      ),
      body: Column(
        children: [
          TextFieldWidget(
            label: 'Nome do arquivo',
            hint: 'Digite aqui o nome do seu novo arquivo',
            controller: TextEditingController(),
            focusNode: FocusNode(),
          ),
        ],
      ),
    );
  }
}
