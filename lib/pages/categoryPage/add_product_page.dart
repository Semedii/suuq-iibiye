import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/components/small_button.dart';
import 'package:suuq_iibiye/models/feature.dart';
import 'package:suuq_iibiye/notifiers/add_product/add_product_notifier.dart';
import 'package:suuq_iibiye/notifiers/add_product/add_product_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';
import 'package:suuq_iibiye/utils/field_validators.dart';
import 'package:suuq_iibiye/utils/pop_up_message.dart';

@RoutePage()
class AddProductPage extends ConsumerWidget {
  AddProductPage({required this.category, super.key});

  final Category category;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addProductNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addNewProduct),
      ),
      body: _mapStateToWidget(context, state, ref),
    );
  }

  Widget _mapStateToWidget(
      BuildContext context, AddProductState state, WidgetRef ref) {
        AppLocalizations localizations = AppLocalizations.of(context)!;
    if (state is AddProductIdleState) {
      return _buildPageBody(context, state, ref);
    } else if (state is AddProductSuccessState) {
      toastInfo(localizations.successfullyAdded);
      AutoRouter.of(context).replace(CategoryRoute(category: category));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryNotifierProvider.notifier).initPage(
              categoryToString(category),
            );
      });
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildPageBody(
    BuildContext context,
    AddProductIdleState state,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    final provider = ref.read(addProductNotifierProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: AppStyles.edgeInsetsH16V24,
            child: Column(
              children: [
                _buildNameField(localizations, state, provider),
                _buildPriceField(localizations, state, provider),
                _buildDescriptionField(localizations, state, provider),
                _buildUploadImageButton(ref, state, localizations),
                _buildAddedFeatures(state, provider),
                _buildFeatureFieldRow(ref, localizations),
                _buildAddButton(ref, state, context),
                _buildCancelButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildNameField(
    AppLocalizations localizations,
    AddProductIdleState state,
    AddProductNotifier addProductProvider,
  ) {
    return _getTextField(
      hintText: localizations.productName,
      initialValue: state.name,
      validator: (value) => FieldValidators.required(value, localizations),
      onChanged: addProductProvider.onNameChanged,
    );
  }

  Padding _buildPriceField(
    AppLocalizations localizations,
    AddProductIdleState state,
    AddProductNotifier addProductProvider,
  ) {
    return _getTextField(
      hintText: localizations.price,
      initialValue: state.price,
      validator: (value) => FieldValidators.required(value, localizations),
      onChanged: addProductProvider.onPriceChanged,
      isNumber: true,
    );
  }

  Padding _buildDescriptionField(
    AppLocalizations localizations,
    AddProductIdleState state,
    AddProductNotifier addProductProvider,
  ) {
    return _getTextField(
      hintText: localizations.productDescription,
      initialValue: state.description,
      onChanged: addProductProvider.onDescriptionChanged,
      maxLines: 3,
    );
  }

  Column _buildUploadImageButton(
    WidgetRef ref,
    AddProductIdleState state,
    AppLocalizations localizations,
  ) {
    return Column(
      children: [
        SmallButton(
          title: localizations.uploadImage,
          onPressed:
              ref.read(addProductNotifierProvider.notifier).onUploadImage,
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

  Wrap _buildAddedFeatures(
      AddProductIdleState state, AddProductNotifier provider) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: state.features
          .where((feature) => feature != null)
          .map((feature) => _buildFeaureItem(feature!, provider))
          .toList(),
    );
  }

  Container _buildFeaureItem(Feature feature, AddProductNotifier provider) {
    return Container(
      padding: AppStyles.edgeInsets4,
      margin: AppStyles.edgeInsets4,
      color: AppColors.green.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feature.title,
            style: const TextStyle(
                color: AppColors.green, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(feature.value),
              TextButton(
                  onPressed: () => provider.onFeaturesRemoved(feature),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureFieldRow(WidgetRef ref, AppLocalizations localizations) {
    TextEditingController title = TextEditingController();
    TextEditingController value = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: title,
              decoration: _getInputDecoration("Camera"),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextFormField(
              controller: value,
              decoration: _getInputDecoration("48MP"),
            ),
          ),
          SmallButton(
              title: localizations.add,
              onPressed: () {
                Feature newFeature =
                    Feature(title: title.text, value: value.text);
                ref
                    .read(addProductNotifierProvider.notifier)
                    .onFeaturesAdded(newFeature);
                title.clear();
                value.clear();
              })
        ],
      ),
    );
  }

  Padding _getTextField({
    String? initialValue,
    required String hintText,
    Function(String)? onChanged,
    bool isNumber = false,
    String? Function(String?)? validator,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: _getInputDecoration(hintText),
        keyboardType: isNumber ? TextInputType.number : null,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
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

  AppButton _buildCancelButton(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return AppButton(
      isTransparent: true,
      title: localizations.cancel,
      onTap: () => Navigator.of(context).pop(),
    );
  }

  AppButton _buildAddButton(
    WidgetRef ref,
    AddProductIdleState state,
    BuildContext context,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return AppButton(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          if (state.images == null) {
            toastInfo(localizations.atleastOneImage);
            return;
          }
          ref.read(addProductNotifierProvider.notifier).addNewProduct(category);
        }
      },
      title: localizations.add,
    );
  }
}
