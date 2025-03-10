import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/home/data/models/best_sellers_response/product.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
        ),
        body: BlocConsumer<WishlistCubit, WishlistStates>(
          listener: (context, state) {
            if (state is DeleteFromWishlistSuccessState) {
              Navigator.pop(context);
              showSuccessToast(context, "Deleted from wishlist");
            } else if (state is DeleteFromWishlistLoadingState) {
              showLoadingDialog(context);
            } else if (state is WishlistErrorState) {
              Navigator.pop(context);
              showErrorToast(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is! GetWishlistSuccessState &&
                state is! DeleteFromWishlistSuccessState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Product> products =
                context.read<WishlistCubit>().wishlistResponse?.data?.data ??
                    [];
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
                      return WishlistItem(product: products[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  const WishlistItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: product.image ?? '',
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
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getBodyTextStyle(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<WishlistCubit>()
                          .deleteFromWishlist(product.id ?? 0);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  )
                ],
              ),
              Text(
                product.price ?? '',
                style: getBodyTextStyle(),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      height: 40,
                      width: 180,
                      radius: 4,
                      text: 'Add to Cart',
                      onPressed: () {}),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
