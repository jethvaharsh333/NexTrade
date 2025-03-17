import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextrade/core/common/widgets/input_field.dart';
import 'package:nextrade/core/common/widgets/loader.dart';
import 'package:nextrade/core/common/widgets/submit_gradient_button.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/profile/presentation/bloc/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile", style: TextStyle(fontWeight: FontWeight.w900)),
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Edit picture or avatar"),
                  ],
                ),
                const SizedBox(height: 27),
                BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if(state is ProfileEditFailure){
                        showSnackBar(context, state.message);
                      }
                      if(state is ProfileEditSuccess){
                        showSnackBar(context, "Successfully registered");
                        Navigator.pop(context);
                      }
                    },
                  builder: (context, state) {
                    if(state is ProfileLoading){
                      return const Loader();
                    }
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputField(
                            hintText: 'Name',
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          InputField(
                            hintText: 'Email',
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          InputField(
                            hintText: 'Username',
                            controller: usernameController,
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          InputField(
                            hintText: 'Phone number',
                            controller: phoneController,
                          ),
                          const SizedBox(
                            height: 27,
                          ),
                          SubmitGradientButton(
                            buttonText: "Update",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<ProfileBloc>().add(
                                      ProfileEditClickedEvent(
                                        userName: usernameController.text.trim(),
                                        email: emailController.text.trim(),
                                        name: nameController.text.trim(),
                                        phoneNumber: phoneController.text.trim(),
                                      ),
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          )),
    );
  }
}
