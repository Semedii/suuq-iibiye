import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/notifiers/edit_product/edit_product_notifier.dart';
import 'package:suuq_iibiye/notifiers/edit_product/edit_product_state.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

@RoutePage()
class EditProductPage extends ConsumerWidget {
  const EditProductPage({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProductState = ref.watch(editProductNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.editPrice,
        ),
      ),
      body: _mapStateToWidget(context, editProductState, ref),
    );
  }

  Widget _mapStateToWidget(
    BuildContext context,
    EditProductState state,
    WidgetRef ref,
  ) {
    if (state is EditProductInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(editProductNotifierProvider.notifier).initPage(productId);
      });
    } else if (state is EditProductLoadedState) {
      return _buildPageBody(context, ref, state);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildPageBody(
    BuildContext context,
    WidgetRef ref,
    EditProductLoadedState state,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    var editProvider = ref.read(editProductNotifierProvider.notifier);
    return SingleChildScrollView(
      child: Padding(
        padding: AppStyles.edgeInsetsH16,
        child: Column(
          children: [
            _buildTextFieldWithLabel(
              localizations.description,
              state.name,
              onChanged: editProvider.onProductNameChanged,
            ),
            _buildTextFieldWithLabel(
              localizations.price,
              state.price.toString(),
              onChanged: editProvider.onPriceChanged,
            ),
            _buildTextFieldWithLabel(
              localizations.description,
              state.description,
              maxLines: 5,
              onChanged: editProvider.onDescriptionChanged,
            ),
            ...state.features!.map((e) => _buildFeature(e.title, e.value)),
           
            _buildUpdateButton(ref),
             _buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabel(String label, String? value,
      {int? maxLines, Function(String)? onChanged}) {
    return Padding(
      padding: AppStyles.edgeInsetsT4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextFormField(
            initialValue: value,
            maxLines: maxLines,
            decoration: _getInputDecoration(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Widget _buildFeature(String? title, String? value) {
    return Padding(
      padding: AppStyles.edgeInsetsT4,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: title,
              decoration: _getInputDecoration(),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextFormField(
              initialValue: value,
              decoration: _getInputDecoration(),
            ),
          ),
        ],
      ),
    );
  }

  TextButton _buildCancelButton(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(localizations.cancel),
    );
  }

  AppButton _buildUpdateButton(WidgetRef ref) {
    return AppButton(
        title: "Update",
        onTap: () =>
            ref.read(editProductNotifierProvider.notifier).onUpdate(productId));

    // ElevatedButton(
    //   onPressed: () {
    //     String price = priceController.text.trim();
    //     String description = descriptionController.text.trim();
    //     if (price.isNotEmpty && description.isNotEmpty) {
    //       ref.read(categoryNotifierProvider.notifier).updatePriceAndDescription(
    //           product, double.parse(price), description);
    //       Navigator.pop(context);
    //     }
    //   },
    //   child: Text(localizations.save),
    // );
  }
}
