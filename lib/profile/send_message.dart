import 'package:equipment/profile/repository/profile_repository.dart';
import 'package:equipment/widgets/text_extension.dart';
import 'package:equipment/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';

import '../other/other.dart';

class SendMessage extends StatelessWidget {
  SendMessage({Key? key, required this.email}) : super(key: key);
  final formKey = GlobalKey<FormBuilderState>();
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/logo.svg'),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('assets/back-arrow.svg')),
                ],
              ),
              const SizedBox(height: 200),
              const Text('Какой у вас вопрос').style16w700(color: Colors.white),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'theme',
                          decoration: AppDecoration.input('Тема', '', fillColor: AppColor.profileInputColor),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Обязательно для заполнения'),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                            name: 'messagge',
                            decoration: AppDecoration.input('Текст сообщения', '', fillColor: AppColor.profileInputColor),
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 6,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Обязательно для заполнения'),
                            ])),
                        const SizedBox(height: 25),
                        AppFilledButton('Отправить', backgroundColor: AppColor.blueColor, onPressed: () {
                          if (formKey.currentState?.saveAndValidate() ?? false) {
                            final service = GetIt.instance.get<ProfileRepository>();
                            service.sendMail(username, formKey.currentState?.fields['messagge']?.value,
                                formKey.currentState?.fields['theme']?.value + ' ' + email);
                            Navigator.pop(context);
                          }
                          print(formKey.currentState?.value.toString());
                        }),
                        const SizedBox(height: 10),
                      ],
                    )),
              )
            ],
          ),
        )));
  }
}
