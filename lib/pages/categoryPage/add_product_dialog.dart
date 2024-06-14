import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/feature.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';
import 'package:suuq_iibiye/utils/field_validators.dart';

class AddProductDialog extends ConsumerWidget {
  AddProductDialog({required this.category, super.key});

  final Category category;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController extraDescriptionController =
      TextEditingController();

  final TextEditingController titleController1 = TextEditingController();
  final TextEditingController detailController1 = TextEditingController();
  final TextEditingController titleController2 = TextEditingController();
  final TextEditingController detailController2 = TextEditingController();
  final TextEditingController titleController3 = TextEditingController();
  final TextEditingController detailController3 = TextEditingController();
  final TextEditingController titleController4 = TextEditingController();
  final TextEditingController detailController4 = TextEditingController();
  final TextEditingController titleController5 = TextEditingController();
  final TextEditingController detailController5 = TextEditingController();

  final List<Feature> features = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryNotifierProvider);
    return categoryState is CategoryStateLoaded
        ? _buildAddNewProductDialog(context, categoryState, ref)
        : const SizedBox.shrink();
  }

  Dialog _buildAddNewProductDialog(
    BuildContext context,
    CategoryStateLoaded state,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Dialog(
      insetPadding: AppStyles.edgeInsetsH16,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: AppStyles.edgeInsetsH16V24,
            child: Column(
              children: [
                _buildDescriptionFeild(localizations),
                _buildPriceField(localizations),
                _buildUploadImageButton(ref, state, localizations),
                _buildDetailsField(),
                _buildFeatureSection(),
                _buildAddButton(ref, state, context), 
                _buildCancelButton(context),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildDetailsField() {
    return TextField(
      controller: extraDescriptionController,
      maxLines: 5,
      decoration: _getInputDecoration("Faahfaahin dheeraada"),
    );
  }

  Widget _buildDescriptionFeild(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: descriptionController,
        decoration: _getInputDecoration(localizations.description),
        validator: (value) => FieldValidators.required(value, localizations),
      ),
    );
  }

  Widget _buildPriceField(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: priceController,
        decoration: _getInputDecoration(localizations.price),
        keyboardType: TextInputType.number,
        validator: (value) => FieldValidators.required(value, localizations),
      ),
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

  Widget _buildFeatureSection() {
    return Column(
      children: [
        Text(
            "Ku dar features ay alaabtu leedahay sida sanadka uu soo baxay, guarantee inta sano, size ama colors available-ka ah, hadii kale iska dhaaf "),
        _buildFeatureRow(titleController1, detailController1),
        _buildFeatureRow(titleController2, detailController2),
        _buildFeatureRow(titleController3, detailController3),
        _buildFeatureRow(titleController4, detailController4),
        _buildFeatureRow(titleController5, detailController5),
      ],
    );
  }

  Widget _buildFeatureRow(titleController, detailController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: titleController,
              decoration: _getInputDecoration("Sizes"),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextFormField(
              controller: detailController,
              decoration: _getInputDecoration("39-44"),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      filled: true,
      fillColor: Colors.grey[200],
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
        addFeaturesToList();
        if (_formKey.currentState!.validate()) {
          String description = descriptionController.text.trim();
          String price = priceController.text.trim();
          ref.read(categoryNotifierProvider.notifier).addNewProduct(Product(
                sellerName: "",
                sellerEmail: "",
                imageUrl: [],
                description: description,
                price: double.parse(price),
                category: category,
                features: features,
                extraDescription: extraDescriptionController.text.trim(),
              ));
          Navigator.pop(context);
        }
      },
      child: Text(localizations.add),
    );
  }

  void addFeaturesToList() {
    if (titleController1.text.isNotEmpty && detailController1.text.isNotEmpty) {
      Feature newFeature = Feature(title: titleController1.text, value: detailController1.text);
      features.add(newFeature);
    }
    if (titleController2.text.isNotEmpty && detailController2.text.isNotEmpty) {
      Feature newFeature = Feature(title: titleController2.text, value: detailController2.text);
      features.add(newFeature);
    }
    if (titleController3.text.isNotEmpty && detailController3.text.isNotEmpty) {
     Feature newFeature = Feature(title: titleController3.text, value: detailController3.text);
      features.add(newFeature);
    }
    if (titleController4.text.isNotEmpty && detailController4.text.isNotEmpty) {
     Feature newFeature = Feature(title: titleController4.text, value: detailController4.text);
      features.add(newFeature);
    }
    if (titleController5.text.isNotEmpty && detailController5.text.isNotEmpty) {
     Feature newFeature = Feature(title: titleController5.text, value: detailController5.text);
      features.add(newFeature);
    }
  }
}
