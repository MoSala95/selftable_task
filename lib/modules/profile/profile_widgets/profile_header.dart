import 'package:flutter/material.dart';
import 'package:selftable_task/models/user_model.dart';
import 'package:selftable_task/shared_widgets/circle_network_image.dart';
import 'package:selftable_task/ui_helpers/ui_textStyles.dart';
class ProfileHeader extends StatelessWidget {
  final UserModel userModel;
  const ProfileHeader({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userModel.name,style: UiTextStyles.largeTitleStyle,),
              SizedBox(height: 10,),
              Text("Age : ${userModel.age}",style:UiTextStyles.boldSubTitleStyle,)
            ],
          ),
          CircleNetworkImage(
            image:userModel.photoUrl ,
          )
        ],
      ),
    );
  }
}
