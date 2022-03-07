import 'package:demo_go_router/blocs/cart/cart_bloc.dart';
import 'package:demo_go_router/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShopItem extends StatelessWidget {
  final Product product;
  const ShopItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .push('/product-detail', extra: {'item': product});
                },
                child: Column(
                  children: [
                    Text('${product.name}'),
                    SizedBox(height: 6.0),
                    Text('${product.price * 1000} đ'),
                  ],
                )),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(AddItemEvent(product));
              },
              child: Text('Add to cart')),
        ],
      ),
    );
  }
}
