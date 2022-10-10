import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBarWithoutAnything(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: InkWell(
                  onTap: () {},
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
                    child: Column(
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
                          'Add Layout Image',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: defaultColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                        // hintStyle: Theme.of(context).textTheme.caption,
                        // hintText: '....',
                        labelText: 'Price',
                        labelStyle: Theme.of(context).textTheme.caption,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: defaultColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: defaultColor,
                            size: 20,
                          ),
                          Text(
                            'Add Product Image',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                        // hintStyle: Theme.of(context).textTheme.caption,
                        // hintText: '....',
                        labelText: 'Price',
                        labelStyle: Theme.of(context).textTheme.caption,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    // hintStyle: Theme.of(context).textTheme.caption,
                    // hintText: '....',
                    labelText: 'Product Name',
                    labelStyle: Theme.of(context).textTheme.caption,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              TextFormField(
                maxLines: 10,
                textAlign: TextAlign.start,
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
                child: DefaultElevatedButton(
                  header: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
