import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';
import 'package:suuq_iibiye/utils/field_validators.dart';

class AddProductDialog extends ConsumerWidget {
  AddProductDialog({required this.category, super.key});

  final Category category;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryNotifierProvider);
    return categoryState is CategoryStateLoaded
        ? _buildAddNewProductDialog(context, categoryState, ref)
        : const SizedBox.shrink();
  }

  AlertDialog _buildAddNewProductDialog(
    BuildContext context,
    CategoryStateLoaded state,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(localizations.addNewProduct),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDescriptionFeild(localizations),
              _buildPriceField(localizations),
              _buildUploadImageButton(ref, state, localizations),
            ],
          ),
        ),
      ),
      actions: [
        _buildCancelButton(context),
        _buildAddButton(ref, state, context),
      ],
    );
  }

  TextFormField _buildDescriptionFeild(AppLocalizations localizations) {
    return TextFormField(
      controller: descriptionController,
      decoration: InputDecoration(labelText: localizations.description),
      validator: (value) => FieldValidators.required(value, localizations),
    );
  }

  TextFormField _buildPriceField(AppLocalizations localizations) {
    return TextFormField(
      controller: priceController,
      decoration: InputDecoration(labelText: localizations.price),
      keyboardType: TextInputType.number,
      validator: (value) => FieldValidators.required(value, localizations),
    );
  }

  Column _buildUploadImageButton(
    WidgetRef ref,
    CategoryStateLoaded state,
    AppLocalizations localizations,
  ) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: ref.read(categoryNotifierProvider.notifier).onUploadImage,
          child: Text(localizations.uploadImage),
        ),
        if (state.images != null && state.images!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check),
              Text(
                  "${localizations.uploaded} ${state.images?.length} ${localizations.image}"),
            ],
          ),
      ],
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

  ElevatedButton _buildAddButton(
    WidgetRef ref,
    CategoryStateLoaded state,
    BuildContext context,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          String description = descriptionController.text.trim();
          String price = priceController.text.trim();
          ref.read(categoryNotifierProvider.notifier).addNewProduct(Product(
              sellerName: "",
              sellerEmail: "",
              imageUrl: [],
              description: description,
              price: double.parse(price),
              category: category));
          Navigator.pop(context);
        }
      },
      child: Text(localizations.add),
    );
  }
}
