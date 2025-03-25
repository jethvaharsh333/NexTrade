import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextrade/core/common/widgets/input_field.dart';
import 'package:nextrade/core/common/widgets/submit_gradient_button.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/profile/presentation/bloc/profile_bloc.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit password", style: TextStyle(fontWeight: FontWeight.w900)),
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is PasswordEditFailure) {
            showSnackBar(context, state.message);
          }
          if (state is PasswordEditSuccess) {
            showSnackBar(context, "Successfully registered");
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, ProfileState state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                        "Your password must be atleast 12 characters and should include a combination of numbers, letters and special characters.",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 27),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputField(
                            hintText: 'Current Password',
                            controller: currentPasswordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          InputField(
                            hintText: 'New Password',
                            controller: newPasswordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          InputField(
                            hintText: 'Confirm Password',
                            controller: confirmPasswordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 27,
                          ),
                          SubmitGradientButton(
                              buttonText: "Update password",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<ProfileBloc>().add(PasswordEditClickedEvent(
                                      confirmPassword: confirmPasswordController.text.trim(),
                                      currentPassword: currentPasswordController.text.trim(),
                                      newPassword: newPasswordController.text.trim()));
                                } // Priti.j999999
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
