import 'package:bookia/core/extenstions/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/feature/home/data/models/best_sellers_response/product.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_states.dart';
import 'package:bookia/feature/home/presentation/page/book_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PopularBooksBuilder extends StatefulWidget {
  const PopularBooksBuilder({super.key});

  @override
  State<PopularBooksBuilder> createState() => _PopularBooksBuilderState();
}

class _PopularBooksBuilderState extends State<PopularBooksBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getBestSeller();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Books',
            style: getTitleTextStyle(),
          ),
          Gap(10),
          booksList(),
        ],
      ),
    );
  }

  BlocBuilder<HomeCubit, HomeStates> booksList() {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (_, state) =>
          state is BestSellerSuccessState ||
          state is BestSellerLoadingState ||
          state is BestSellerErrorState,
      builder: (context, state) {
        if (state is! BestSellerSuccessState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product> books =
            context.read<HomeCubit>().bestSellersResponse?.data?.products ?? [];
        return GridView.builder(
          itemCount: books.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 280,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.pushTo(BookDetailsScreen(
                  product: books[index],
                ));
              },
              child: BookItem(
                product: books[index],
              ),
            );
          },
        );
      },
    );
  }
}

class BookItem extends StatelessWidget {
  const BookItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: product.id ?? '',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: product.image ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Gap(10),
          Text(
            product.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getBodyTextStyle(),
          ),
          Gap(10),
          Row(children: [
            Text(
              '\$${product.priceAfterDiscount}',
              style: getSmallTextStyle(),
            ),
            const Spacer(),
            CustomButton(
                height: 30,
                bgColor: AppColors.darkColor,
                width: 90,
                radius: 4,
                text: 'Buy',
                onPressed: () {})
          ])
        ],
      ),
    );
  }
}
