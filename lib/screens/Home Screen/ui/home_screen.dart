import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';
import 'package:xdg_directories/xdg_directories.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/secrets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? file;

  @override
  void initState() {
    // context.read<HomeBloc>().emit(HomeSuccess());
    super.initState();
  }

  // void getPromptResult(String prompt) async {
  //   final dio = Dio();
  //   final headers = {"Authorization": "Bearer $imagineAPIKey"};
  //   final formdata = FormData.fromMap({"prompt": prompt, "style_id": 31});
  //   final response = await dio.post(
  //       'https://api.vyro.ai/v1/imagine/api/generations',
  //       options: Options(
  //           method: "POST", headers: headers, responseType: ResponseType.bytes),
  //       data: formdata);

  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     // File file = File("genImage.jpg");
  //     // file.writeAsBytesSync(response.data);
  //     setState(() {
  //       file = Uint8List.fromList(response.data);
  //     });
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }

  final TextEditingController promtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Generate Image 🚀",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is HomeSuccess) {
                  return Stack(
                    children: [
                      Image.memory(state.image!),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: FloatingActionButton.extended(
                          icon: const Icon(Icons.save_alt_rounded),
                          onPressed: () {
                            context.read<HomeBloc>().add(
                                SaveGeneratedImageToLocalStorageClickedEvent(
                                    state.image!, promtController.text));
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Image Saved")));
                          },
                          label: const Text("Save Image to Local"),
                        ),
                      )
                    ],
                  );
                }
                return CachedNetworkImage(
                    height: 500,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    imageUrl:
                        "https://plus.unsplash.com/premium_photo-1680740103993-21639956f3f0?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter your Prompt",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: promtController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        print("pressed");
                        context.read<HomeBloc>().add(
                              GenerateButtonClickedEvent(promtController.text),
                            );
                        // getPromptResult(promtController.text);
                      },
                      icon: const Icon(Icons.search),
                      label: const Text("Generate✨"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
