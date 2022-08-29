import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/globals/global_enums.dart';
import 'package:selftable_task/modules/cats/cats_controller.dart';
import 'package:selftable_task/shared_widgets/app_state_handler_widget.dart';
import 'package:selftable_task/shared_widgets/circle_network_image.dart';
import 'package:selftable_task/shared_widgets/gradient_add_button.dart';
import 'package:selftable_task/shared_widgets/gradient_remove_button.dart';
import 'package:selftable_task/shared_widgets/shimmer/vertical_shimmer.dart';
import 'package:selftable_task/ui_helpers/color_constants.dart';
import 'package:selftable_task/ui_helpers/ui_textStyles.dart';

class CatsScreen extends StatelessWidget {
  CatsScreen({Key? key}) : super(key: key);
  final catsController = Get.find<CatsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CatsController>(builder: (_) {
          return AppStateHandlerWidget(
            state: catsController.loadingState,
            isShimmer: catsController.allCats.isEmpty,
            shimmerWidget: VerticalListShimmerWidget(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Featured",
                        style: UiTextStyles.largeTitleStyle,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: catsController.featuredCats.isEmpty
                            ? 1
                            : catsController.featuredCats.length,
                        itemBuilder: (context, index) {
                          if (catsController.featuredCats.isEmpty)
                            return Container();

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(15)),
                                  border: Border.all(color: Colors.black54)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CircleNetworkImage(
                                    image: catsController
                                        .featuredCats[index].image,
                                    imageHeight: 100,
                                    imageWidth: 100,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          catsController
                                              .featuredCats[index].name,
                                          style: UiTextStyles.boldSubTitleStyle,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(catsController
                                            .featuredCats[index].desc),
                                        if (catsController.checkIfInFavList(
                                            catModel: catsController
                                                .featuredCats[index]))
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: GradientRemoveButton(
                                                onTap: () {
                                                  catsController.onRemoveCat(
                                                      catModel: catsController
                                                          .featuredCats[index]);
                                                },
                                              ))
                                        else
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: GradientAddButton(
                                                onTap: () {
                                                  catsController.onAddCat(
                                                      catModel: catsController
                                                          .featuredCats[index]);
                                                },
                                              ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "All Cats",
                        style: UiTextStyles.largeTitleStyle,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: catsController.allCats.isEmpty
                            ? 1
                            : catsController.allCats.length,
                        itemBuilder: (context, index) {
                          if (catsController.allCats.isEmpty)
                            return Container();

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(15)),
                                  border: Border.all(color: Colors.black54)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CircleNetworkImage(
                                    image: catsController.allCats[index].image,
                                    imageHeight: 100,
                                    imageWidth: 100,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          catsController.allCats[index].name,
                                          style: UiTextStyles.boldSubTitleStyle,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            catsController.allCats[index].desc),
                                        if (catsController.checkIfInFavList(
                                            catModel:
                                                catsController.allCats[index]))
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: GradientRemoveButton(
                                                onTap: () {
                                                  catsController.onRemoveCat(
                                                      catModel: catsController
                                                          .allCats[index]);
                                                },
                                              ))
                                        else
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: GradientAddButton(
                                                onTap: () {
                                                  catsController.onAddCat(
                                                      catModel: catsController
                                                          .allCats[index]);
                                                },
                                              ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
