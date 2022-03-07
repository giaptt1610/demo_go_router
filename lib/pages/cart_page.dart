import 'package:demo_go_router/blocs/cart/cart_bloc.dart';
import 'package:demo_go_router/routes/app_router.dart';
import 'package:demo_go_router/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service_locator.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart, ${router.router.location}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('List items:'),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final products = state.items.keys.toList();

                return Expanded(
                  child: ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return CartItem(product: products[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
