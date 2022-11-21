import 'dart:convert';

import 'package:beauty_supplies_project/models/category.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../categories/cubit/categories_cubit.dart';
import '../../categories/cubit/categories_state.dart';
import 'cubit/admin_upload_product_cubit.dart';
import 'cubit/admin_upload_product_state.dart';

class AdminViewUploadProduct extends StatelessWidget {
  AdminViewUploadProduct({Key? key}) : super(key: key);

  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String categoryItem = '';
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: BlocBuilder<AdminUploadProductViewCubit,
                      AdminUploadProductViewState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<AdminUploadProductViewCubit>()
                              .pickImageBase64();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: defaultColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: context
                                      .read<AdminUploadProductViewCubit>()
                                      .base64String !=
                                  null
                              ? Container(
                                  padding: const EdgeInsets.all(1),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.memory(
                                    base64Decode(
                                      context
                                          .read<AdminUploadProductViewCubit>()
                                          .base64String!,
                                    ),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: defaultColor,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Add Product Image',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: defaultColor),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // hintStyle: Theme.of(context).textTheme.caption,
                          // hintText: '....',
                          labelText: 'Price',
                          labelStyle: Theme.of(context).textTheme.caption,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: discountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // hintStyle: Theme.of(context).textTheme.caption,
                          // hintText: '....',
                          labelText: 'Discount',
                          suffix: const Text('%'),
                          labelStyle: Theme.of(context).textTheme.caption,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Select Category',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: BlocBuilder<CategoriesCubit, CategoriesState>(
                          builder: (context, state) {
                            return StreamBuilder<List<CategoryModel>>(
                              stream: context
                                  .read<CategoriesCubit>()
                                  .categoryStream(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  final category = snapshot.data;
                                  if (category == null || category.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No Category Available yet!',
                                      ),
                                    );
                                  }

                                  return BlocBuilder<
                                      AdminUploadProductViewCubit,
                                      AdminUploadProductViewState>(
                                    builder: (context, state) {
                                      categoryItem = context
                                          .read<AdminUploadProductViewCubit>()
                                          .selectedCategory;
                                      if (categoryItem == '') {
                                        categoryItem = category[0].name;
                                      }
                                      return DropdownButton(
                                        borderRadius: BorderRadius.circular(15),
                                        alignment: AlignmentDirectional.center,
                                        value: categoryItem,
                                        elevation: 15,
                                        underline: Container(),
                                        isExpanded: true,
                                        focusColor: Colors.grey,
                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        dropdownColor: Colors.grey[300],
                                        items: List.generate(
                                          category.length,
                                          (index) => DropdownMenuItem(
                                            value: category[index].name,
                                            child: Text(category[index].name),
                                          ),
                                        ),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? category) {
                                          context
                                              .read<
                                                  AdminUploadProductViewCubit>()
                                              .changeSelectedCategory(
                                                  category!);
                                        },
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) return 'It must not be empty';

                      return null;
                    },
                    decoration: InputDecoration(
                      // hintStyle: Theme.of(context).textTheme.caption,
                      // hintText: '....',
                      labelText: 'Product Title',
                      labelStyle: Theme.of(context).textTheme.caption,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) return 'It must not be empty';

                    return null;
                  },
                  decoration: InputDecoration(
                    // hintStyle: Theme.of(context).textTheme.caption,
                    // hintText: '....',
                    hintText: 'Product Description',
                    hintStyle: Theme.of(context).textTheme.caption,
                    border: const OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: BlocConsumer<AdminUploadProductViewCubit,
                      AdminUploadProductViewState>(
                    listener: (context, state) {
                      if (state
                          is AdminViewPostProductAtAdminPathSuccessState) {
                        context
                            .read<AdminUploadProductViewCubit>()
                            .resetBase64();
                        priceController.clear();
                        discountController.clear();
                        titleController.clear();
                        descriptionController.clear();
                        showToast(
                            text: 'Product uploaded successfully',
                            color: Colors.green);
                      } else if (state
                              is AdminViewPostProductAtAdminPathErrorState ||
                          state
                              is AdminViewPostProductAtProductsPathErrorState) {
                        showToast(
                          text:
                              'Failed! Please reduce image size or check internet',
                          color: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      var cubit = context.read<AdminUploadProductViewCubit>();
                      return (state
                              is AdminViewPostProductAtAdminPathLoadingState)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : DefaultElevatedButton(
                              header: Text(
                                'Submit',
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              onPressed: () => submitConditions(
                                  formKey, cubit, categoryItem),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitConditions(GlobalKey<FormState> formKey,
      AdminUploadProductViewCubit cubit, String category) {
    cubit.createNewIdState();
    if (formKey.currentState!.validate()) {
      if (cubit.base64String == null) {
        showToast(text: 'Please Add product image first', color: Colors.red);
      } else if (cubit.imageSize >= 1) {
        showToast(
            text: 'Image size should be less than one mega', color: Colors.red);
      } else if (priceController.text.isEmpty) {
        showToast(text: 'Price should not be empty', color: Colors.red);
      } else if (discountController.text.isEmpty) {
        showToast(
            text: 'Discount Price should not be empty', color: Colors.red);
      } else if (checkValue(priceController.text) ||
          checkValue(discountController.text)) {
        showToast(text: 'Invalid Number', color: Colors.red);
      } else if (discountController.text.length > 2) {
        showToast(
            text: 'Discount value must be less than three number',
            color: Colors.red);
      } else if (priceController.text.length > 8) {
        showToast(
            text: 'Price must be less than nine number', color: Colors.red);
      } else {
        cubit.setProductAtPathAdmin(
          ProductModel(
            id: cubit.newId!,
            description: descriptionController.text,
            title: titleController.text,
            price: int.parse(priceController.text),
            imgUrl: cubit.base64String!,
            category: category,
            discountValue: discountController.text.isEmpty
                ? 0
                : int.parse(discountController.text),
            rate: 0,
          ),
        );
      }
    }
  }

  bool checkValue(String v) {
    for (var i = 0; i < v.length; ++i) {
      if (v[i] != '0' ||
          v[i] != '1' ||
          v[i] != '2' ||
          v[i] != '3' ||
          v[i] != '4' ||
          v[i] != '5' ||
          v[i] != '6' ||
          v[i] != '7' ||
          v[i] != '8' ||
          v[i] != '9') return false;
    }
    return true;
  }
}
