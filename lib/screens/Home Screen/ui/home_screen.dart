
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController promptController = TextEditingController();

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
                                    state.image!, promptController.text));

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
                    controller: promptController,
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
                        context.read<HomeBloc>().add(
                              GenerateButtonClickedEvent(promptController.text),
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
