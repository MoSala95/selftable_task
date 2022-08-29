import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';
import 'package:selftable_task/modules/profile/profile_controller.dart';
import 'package:selftable_task/shared_widgets/app_state_handler_widget.dart';
import 'package:selftable_task/shared_widgets/circle_network_image.dart';
import 'package:selftable_task/shared_widgets/gradient_remove_button.dart';
import 'package:selftable_task/ui_helpers/ui_textStyles.dart';

import 'profile_widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ProfileController>(builder: (_) {
        return AppStateHandlerWidget(
          state: profileController.loadingState,
          isShimmer: profileController.userModel==null,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(profileController.userModel!=null)...[
                  ProfileHeader(userModel: profileController.userModel!,),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Text("My Cats",style: UiTextStyles.largeTitleStyle,),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: profileController.favoriteCats.isEmpty ? 1 : profileController
                          .favoriteCats.length,
                      itemBuilder: (context, index) {
                        if (profileController.favoriteCats.isEmpty)
                          return Center(
                            child: Text("You do not have any cats try to add one"));


                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: Get.width,

                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(const Radius.circular(15)),
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleNetworkImage(
                                  image: profileController.favoriteCats[index].image,
                                  imageHeight: 100,
                                  imageWidth: 100,
                                ),
                                const SizedBox(width: 10,),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      Text(profileController.favoriteCats[index].name,style: UiTextStyles.boldSubTitleStyle,),
                                      const SizedBox(width: 10,),
                                      Text(profileController.favoriteCats[index].desc),
                                         Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: GradientRemoveButton(
                                              onTap: (){
                                                profileController.onRemoveCat(catModel: profileController.favoriteCats[index]);

                                              },
                                            )
                                        )

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10,),
                              ],
                            ),
                          ),
                        );
                      }),
              ],]
            ),
          ),
        );
      }),
    );
  }
}
