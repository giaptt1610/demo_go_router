import 'package:demo_go_router/blocs/cart/cart_bloc.dart';
import 'package:demo_go_router/models/product.dart';
import 'package:demo_go_router/routes/app_router.dart';
import 'package:demo_go_router/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatefulWidget {
  final Product product;
  DetailsPage({required this.product, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details, ${router.location}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('${widget.product.name}'),
            Text('${widget.product.desc}'),
            Text('${widget.product.price * 1000} đ'),
            ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddItemEvent(widget.product));
                  GoRouter.of(context).pop();
                },
                child: Text('Add to cart')),
          ],
        ),
      ),
    );
  }
}
