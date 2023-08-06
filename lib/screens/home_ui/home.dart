import 'package:demo_sogin_signup_firebase/models/product_model.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sport Shop",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelStyle: TextStyle(color: Colors.black45),
                      filled: true,
                      labelText: "Search ...",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              width: 2, style: BorderStyle.none)),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Categories...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                            color: Colors.white,
                            elevation: 13.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: SizedBox(
                                height: 90,
                                width: 90,
                                child: Image.network(e),
                              ),
                            )),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 0, bottom: 0),
              child: Text(
                "Top Sales ...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: bestProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25),
                  itemBuilder: (ctx, index) {
                    Product singleProduct = bestProduct[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Image.network(
                            singleProduct.image,
                            scale: 9,
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            singleProduct.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Price: \$${singleProduct.price}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: 140,
                            child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black45,
                                    side: const BorderSide(color: Colors.red)),
                                child: const Text(
                                  "BUY",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

List<String> categories = [
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
  "https://clipart-library.com/image_gallery2/Banana.png",
];
List<Product> bestProduct = [
  Product(
      status: "peding",
      description: "So good for you",
      image: "https://clipart-library.com/image_gallery2/Banana.png",
      id: "1",
      name: "banana",
      price: 1,
      isFavourite: true),
  Product(
      status: "peding",
      description: "So good for you",
      image: "https://clipart-library.com/image_gallery2/Banana.png",
      id: "1",
      name: "banana",
      price: 1,
      isFavourite: true),
  Product(
      status: "peding",
      description: "So good for you",
      image: "https://clipart-library.com/image_gallery2/Banana.png",
      id: "1",
      name: "banana",
      price: 1,
      isFavourite: true),
  Product(
      status: "peding",
      description: "So good for you",
      image: "https://clipart-library.com/image_gallery2/Banana.png",
      id: "1",
      name: "banana",
      price: 1,
      isFavourite: true),
  Product(
      status: "peding",
      description: "So good for you",
      image: "https://clipart-library.com/image_gallery2/Banana.png",
      id: "1",
      name: "banana",
      price: 1,
      isFavourite: true),
  Product(
      status: "peding",
      description: "So good for you",
      image: "https://clipart-library.com/image_gallery2/Banana.png",
      id: "1",
      name: "banana",
      price: 1,
      isFavourite: true),
];
