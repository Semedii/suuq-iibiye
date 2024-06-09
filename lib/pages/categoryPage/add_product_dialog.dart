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

  final List<Map<String, String>> features = []; 

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
              _buildFeatureSection(),
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

  Widget _buildFeatureSection() {
    return Column(
      children: [
        _buildFeatureRow(titleController1, detailController1),
        _buildFeatureRow(titleController2, detailController2),
        _buildFeatureRow(titleController3, detailController3),
        _buildFeatureRow(titleController4, detailController4),
        _buildFeatureRow(titleController5, detailController5),
      ],
    );
  }

  Row _buildFeatureRow(titleController, detailController) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: titleController,
            decoration: _getInputDecoration("Sizes"),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: detailController,
            decoration: _getInputDecoration("39-44"),
          ),
        )
      ],
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
              ));
          Navigator.pop(context);
        }
      },
      child: Text(localizations.add),
    );
  }

  void addFeaturesToList(){
    if(titleController1.text.isNotEmpty && detailController1.text.isNotEmpty){
     Map<String, String>  newFeature = {titleController1.text: detailController1.text};
      features.add(newFeature);
    }
     if(titleController2.text.isNotEmpty && detailController2.text.isNotEmpty){
     Map<String, String>  newFeature = {titleController2.text: detailController2.text};
      features.add(newFeature);
    }
     if(titleController3.text.isNotEmpty && detailController3.text.isNotEmpty){
     Map<String, String>  newFeature = {titleController3.text: detailController3.text};
      features.add(newFeature);
    }
     if(titleController4.text.isNotEmpty && detailController4.text.isNotEmpty){
     Map<String, String>  newFeature = {titleController4.text: detailController4.text};
      features.add(newFeature);
    }
     if(titleController5.text.isNotEmpty && detailController5.text.isNotEmpty){
     Map<String, String>  newFeature = {titleController5.text: detailController5.text};
      features.add(newFeature);
    }
  }
}
