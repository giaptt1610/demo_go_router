import 'package:demo_go_router/blocs/cart/cart_bloc.dart';
import 'package:demo_go_router/models/product.dart';
import 'package:demo_go_router/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart';

import '../service_locator.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final listProducts = <Product>[
    Product(id: '1', name: 'Product 1'),
    Product(id: '2', name: 'Product 2'),
    Product(id: '3', name: 'Product 3'),
    Product(id: '4', name: 'Product 4'),
    Product(id: '5', name: 'Product 5'),
    Product(id: '6', name: 'Product 6'),
  ];

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${router.router.location}'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) {
              return previous.items.length != current.items.length;
            },
            builder: (context, state) {
              return Badge(
                badgeContent: Text('${state.items.length}'),
                showBadge: state.items.isNotEmpty,
                position: BadgePosition(top: 0, end: 5),
                child: IconButton(
                  onPressed: () {
                    router.router.push('/cart');
                  },
                  icon: Icon(Icons.shopping_basket),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: listProducts.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item ${listProducts[index].name}'),
                  subtitle: Text('description item'),
                  onTap: () {
                    context
                        .read<CartBloc>()
                        .add(AddItemEvent(listProducts[index]));
                  },
                ),
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Checkout')),
          ],
        ),
      ),
    );
  }
}
