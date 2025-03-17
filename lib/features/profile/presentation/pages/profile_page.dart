// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:line_icons/line_icons.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   bool _isDarkMode = false; // Track the dark mode toggle state
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text("Profile"),
//       ),
//       body: Container(
//         // color: Colors.white, // White background for the body
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Center(
//               // Center the profile image
//               child: CircleAvatar(
//                 radius: 50,
//                 // backgroundImage: NetworkImage(
//                 //     'https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?t=st=1740189766~exp=1740193366~hmac=2240a996b6eb4a086cc64b0ead940e432f297c080de1d78e1b75834737e6c498&w=900'),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Rita Smith',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   child: const Icon(
//                     LineIcons.userEdit,
//                     size: 24,
//                   ),
//                   onTap: (){
//                     // Navigator.pushNamed(context, '/editprofile');
//                     context.goNamed("EditProfile");
//                   },
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildContactInfo(
//               'Username  ',
//               'harsh1',
//               LineIcons.userTag,
//             ),
//             _buildContactInfo(
//               'Mail  ',
//               'rita@gmail.com',
//               Icons.mail,
//             ),
//             _buildContactInfo(
//               'Phone  ',
//               '+5999-771-7171',
//               Icons.call,
//             ),
//             const SizedBox(height: 20),
//             Divider(color: Colors.grey[300]),
//             // Light grey divider
//             const SizedBox(height: 20),
//             _buildListTile(
//               Icons.lock,
//               'Password and security',
//               'EditPassword'
//             ),
//             _buildListTile(
//               Icons.info_rounded,
//               'About Us',
//               'AboutUs'
//             ),
//
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.logout_rounded, size: 20),
//                   SizedBox(
//                     width: 6,
//                   ),
//                   Text(
//                     'Log out',
//                     style: TextStyle(fontSize: 17, color: Colors.white),
//                   ),
//                 ],
//               ),
//             )
//             // _buildListTile(
//             //   'Dark mode',
//             //   Switch(
//             //     value: _isDarkMode,
//             //     onChanged: (value) {
//             //       setState(() {
//             //         _isDarkMode = value;
//             //         // Implement dark mode toggle logic here
//             //       });
//             //     },
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactInfo(String label, String value, IconData iconName) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(iconName, size: 16),
//               const SizedBox(width: 10),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildListTile(IconData iconName, String title, String routeName) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               Icon(iconName, size: 20),
//               const SizedBox(
//                 width: 6,
//               ),
//               Text(
//                 title,
//                 style: const TextStyle(fontSize: 17, color: Colors.white),
//               ),
//             ],
//           ),
//           InkWell(
//             child: const Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//             ),
//             onTap: (){
//               // Navigator.pushNamed(context, '/$routeName');
//               context.goNamed("$routeName");
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nextrade/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nextrade/core/common/widgets/my_drawer.dart';
import 'package:nextrade/features/auth/presentation/pages/login_page.dart';
import 'package:nextrade/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nextrade/utils/token_storage.dart';

import '../../../../core/utils/show_snackbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if(state is ProfileLogoutFailure){
          return showSnackBar(context, "Unable to delete");
        }
      },
      builder: (context, state) {
        if (state is AppUserLoggedIn) {
          final user = state.user;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("Profile"),
            ),
            drawer: const MyDrawer(),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.name == "" ? "--" : user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: const Icon(LineIcons.userEdit, size: 24),
                        onTap: () {
                          context.goNamed("EditProfile");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildContactInfo('Username', user.userName, LineIcons.userTag),
                  _buildContactInfo('Mail', user.email, Icons.mail),
                  _buildContactInfo('Phone', user.phoneNumber, Icons.call),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  _buildListTile(Icons.lock, 'Password and security', 'EditPassword', context),
                  _buildListTile(Icons.info_rounded, 'About Us', 'AboutUs', context),
                  InkWell(
                    onTap: () async {
                      context.read<ProfileBloc>().add(ProfileLogoutClickedEvent(userName: user.userName, email: user.email));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.logout_rounded, size: 20),
                          SizedBox(width: 6),
                          Text(
                            'Log out',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is !AppUserLoggedIn) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Failed to load user data"));
        }
      },
    );
  }

  Widget _buildContactInfo(String label, String value, IconData iconName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconName, size: 16),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Text(
            value=="" ? "--" : value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData iconName, String title, String routeName, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconName, size: 20),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
            ],
          ),
          InkWell(
            child: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context.goNamed(routeName);
            },
          )
        ],
      ),
    );
  }
}
