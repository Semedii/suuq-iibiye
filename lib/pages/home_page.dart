import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/notifiers/home/home_notifiers.dart';
import 'package:suuq_iibiye/notifiers/home/home_state.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    return _mapStateToWidget(context, ref, homeState);
  }

  Widget _mapStateToWidget(BuildContext context, WidgetRef ref, HomeState state) {
    if (state is HomeStateInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(homeNotifierProvider.notifier).initPage();
      });
    } else if (state is HomeStateLoaded) {
      return _buildHomepageBody(context, state.categories);
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _buildHomepageBody(BuildContext context, List<Category?> categories) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: GridView.builder(
        padding: AppStyles.edgeInsetsH16,
        gridDelegate: _getGridDelegate(),
        itemCount: categories.length, // Total number of items
        itemBuilder: (BuildContext context, int index) {
          final Category category = categories[index]!;
          return _buildCategoryCard(context, category, index);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
     AppLocalizations localizations = AppLocalizations.of(context)!;
    return AppBar(
      centerTitle: true,
      title:  Text(localizations.myProducts),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
      ],
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _getGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );
  }

  GestureDetector _buildCategoryCard(
      BuildContext context, Category category, int index) {
    return GestureDetector(
      onTap: () =>
          AutoRouter.of(context).push(CategoryRoute(category: category)),
      child: GridTile(
        child: Container(
          decoration: _getBoxDecoration(index),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: _buildCategoryTitle(category),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration(int index) {
    return BoxDecoration(
      image: const DecorationImage(
        image: AssetImage(
          "assets/images/tshirt.jpg",
        ),
        fit: BoxFit.cover,
      ),
      color: Colors.blue[100 * (index % 9)],
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          offset: Offset(0.5, 0.5),
        )
      ],
    );
  }

  Text _buildCategoryTitle(Category category) {
    return Text(
      categoryToString(category),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
