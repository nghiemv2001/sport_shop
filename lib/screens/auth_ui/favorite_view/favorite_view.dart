import 'package:demo_sogin_signup_firebase/screens/auth_ui/favorite_view/widgets/single_favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider_model.dart';

class favorite_view extends StatelessWidget {
  const favorite_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider approvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Favourite",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: approvider.getFavoriteProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: approvider.getFavoriteProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingGle_Favourite_item(
                  singProduct: approvider.getFavoriteProductList[index],
                );
              }),
    );
  }
}
