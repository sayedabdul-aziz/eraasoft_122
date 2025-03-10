import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/cart_list/data/models/get_cart_response/cart_item.dart';
import 'package:bookia/feature/cart_list/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart_list/presentation/cubit/cart_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocConsumer<CartCubit, CartStates>(
          listener: (context, state) {
            if (state is DeleteFromCartSuccessState) {
              Navigator.pop(context);
              showSuccessToast(context, "Deleted from Cart");
            } else if (state is DeleteAndUpdateCartLoadingState) {
              showLoadingDialog(context);
            } else if (state is CartErrorState) {
              Navigator.pop(context);
              showErrorToast(context, state.error);
            } else if (state is UpdateCartSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is! GetCartSuccessState &&
                state is! DeleteFromCartSuccessState &&
                state is! UpdateCartSuccessState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<CartItem> products =
                context.read<CartCubit>().cartResponse?.data?.cartItems ?? [];
            return products.isEmpty
                ? const Center(
                    child: Text('No products in wishlist'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 40),
                    itemBuilder: (context, index) {
                      return CartItemWidget(product: products[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.product,
  });

  final CartItem product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: product.itemProductImage ?? '',
            fit: BoxFit.cover,
            width: 100,
            height: 120,
          ),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.itemProductName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getBodyTextStyle(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<CartCubit>()
                          .deleteFromCart(product.itemId ?? 0);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  )
                ],
              ),
              Text(
                product.itemProductPrice ?? '',
                style: getBodyTextStyle(),
              ),
              const Gap(10),
              Row(
                children: [
                  FloatingActionButton.small(
                    elevation: 0,
                    backgroundColor: AppColors.borderColor,
                    onPressed: () {
                      if ((product.itemQuantity ?? 0) > 1) {
                        context.read<CartCubit>().updateCart(
                            product.itemId ?? 0, product.itemQuantity! - 1);
                      } else {
                        showErrorToast(context, 'Minimum quantity is 1');
                      }
                    },
                    child: const Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 20,
                    child: Text(
                      '${product.itemQuantity}',
                      textAlign: TextAlign.center,
                      style: getBodyTextStyle(),
                    ),
                  ),
                  FloatingActionButton.small(
                    elevation: 0,
                    backgroundColor: AppColors.borderColor,
                    onPressed: () {
                      if ((product.itemQuantity ?? 0) <
                          (product.itemProductStock ?? 0)) {
                        context.read<CartCubit>().updateCart(
                            product.itemId ?? 0, product.itemQuantity! + 1);
                      } else {
                        showErrorToast(
                            context, 'Maximum quantity is ${product.itemProductStock}');
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
