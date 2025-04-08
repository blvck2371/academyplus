import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarouselController extends GetxController {
  var currentPage = 0.obs; // Utilisation de GetX pour suivre la page actuelle
  late PageController pageController;
  Timer? _timer;

  // Liste des images
  final List<String> images = [
    'https://cursus.edu/storage/thumbnails/9kDITopJRWhvzBgKru2ooYEGEZ969eHuGkaGTbq8.jpeg',
    'https://ghanaeducation.org/wp-content/uploads/2024/03/ghana_sch-2.jpg',
    'https://charity.org/wp-content/uploads/2022/09/Save-the-Children-01-23-2-1024x683.jpg.webp',
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);

    // Timer pour changer l'image toutes les 10 secondes
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      nextPage();
    });
  }

  // Fonction pour avancer la page
  void nextPage() {
    if (currentPage.value < images.length - 1) {
      currentPage.value++;
    } else {
      currentPage.value = 0; // Revenir à la première image
    }
    pageController!.animateToPage(
      currentPage.value,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Fonction pour revenir à la page précédente
  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    } else {
      currentPage.value = images.length - 1; // Aller à la dernière image
    }
    pageController.animateToPage(
      currentPage.value,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}

class ImageCarouselWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ImageCarouselController controller =
        Get.put(ImageCarouselController());

    return Obx(() {
      return Column(
        children: [
          // PageView pour afficher les images
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Image.network(
                        controller.images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (page) {
                    controller.currentPage.value = page;
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          List.generate(controller.images.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPage.value == index
                                ? Colors.grey
                                : Colors.white,
                          ),
                        );
                      }),
                    ),
                  ),
                ),

// Boutons pour avancer/reculer
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 40,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: controller.prevPage,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 40,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: controller.nextPage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
