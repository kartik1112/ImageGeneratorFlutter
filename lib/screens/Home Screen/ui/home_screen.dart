import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/generic_button_widget.dart';
import 'package:wallpaper_app/widgets/generic_text_field_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    return Stack(
      children: [
        Lottie.asset(
            height: double.infinity,
            fit: BoxFit.fill,
            "lib/assets/auth_bg.json"),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Generate Image 🚀",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(SignOutButtonClickedEvent());
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ],
          ),
          body: Center(
            child: Column(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Lottie.asset(
                            fit: BoxFit.fill, "lib/assets/loading_state.json"),
                      );
                    }
                    if (state is HomeSuccess) {
                      imageData = state.image;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.memory(state.image!),
                        // child: Stack(
                        //   children: [
                        //     Positioned(
                        //       bottom: 10,
                        //       right: 10,
                        //       child: FloatingActionButton.extended(
                        //         icon: const Icon(Icons.save_alt_rounded),
                        //         onPressed: () {
                        //           context.read<HomeBloc>().add(
                        //               SaveGeneratedImageToLocalStorageClickedEvent(
                        //                   state.image!, promptController.text));

                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //               const SnackBar(
                        //                   content: Text("Image Saved")));
                        //         },
                        //         label: const Text("Save Image to Local"),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CachedNetworkImage(
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          imageUrl:
                              "https://plus.unsplash.com/premium_photo-1680740103993-21639956f3f0?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enter your Prompt ${FirebaseAuth.instance.currentUser!.email!.split("@")[0]} 🚀",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GenericTextFieldWidget(
                                  controller: promptController),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: GenericButtonWidget(
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                            GenerateButtonClickedEvent(
                                                promptController.text),
                                          );
                                      // getPromptResult(promtController.text);
                                    },
                                    iconData: Icons.search,
                                    buttonText: "Generate✨",
                                    promptController: promptController),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: GenericButtonWidget(
                                          onTap: () {
                                            context.read<HomeBloc>().add(
                                                  SaveGeneratedImageToLocalStorageClickedEvent(
                                                      imageData!,
                                                      promptController.text),
                                                );

                                            Future.delayed(
                                              const Duration(seconds: 2),
                                              () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("Image Saved"),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          iconData: Icons.save_alt_rounded,
                                          buttonText: "Save to Local",
                                          promptController: promptController),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: GenericButtonWidget(
                                          onTap: () {
                                            // TODO : save data to cloud 

                                            
                                          },
                                          iconData: Ionicons.cloud,
                                          buttonText: "Save to Cloud",
                                          promptController: promptController),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
