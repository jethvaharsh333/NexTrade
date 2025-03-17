import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/core/common/widgets/input_field.dart';
import 'package:nextrade/core/common/widgets/loader.dart';
import 'package:nextrade/core/common/widgets/submit_gradient_button.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/portfolio/presentation/bloc/portfolio_bloc.dart';

class EditPortfolio extends StatefulWidget {
  const EditPortfolio({super.key});

  @override
  State<EditPortfolio> createState() => _EditPortfolioState();
}

class _EditPortfolioState extends State<EditPortfolio> {
  final formKey = GlobalKey<FormState>();
  final stockSymbolController = TextEditingController();
  final investmentDateController = TextEditingController();
  final investmentPriceController = TextEditingController();
  final quantityController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    stockSymbolController.dispose();
    investmentDateController.dispose();
    investmentPriceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void _updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      investmentDateController.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile", style: TextStyle(fontWeight: FontWeight.w900)),
        // leading: InkWell(
        //   child: const Icon(Icons.arrow_back_ios_new_rounded),
        //   onTap: () {
        //     GoRouter.of(context).pushNamed("Portfolio");
        //   },
        // ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Edit picture or avatar"),
                  ],
                ),
                const SizedBox(height: 27),
                BlocConsumer<PortfolioBloc, PortfolioState>(
                    listener: (context, state) {
                      if (state is AddPortfolioFailureState) {
                        showSnackBar(context, state.message);
                      }
                      if (state is AddPortfolioSuccessState) {
                        showSnackBar(context, "Successfully registered");
                        GoRouter.of(context).pop();
                      }
                    },
                    builder: (context, state) {
                      if (state is AddPortfolioLoadingState) {
                        return const Loader();
                      }
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              hintText: 'Price',
                              controller: investmentPriceController,
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            InputField(
                              hintText: 'Investment Date',
                              controller: investmentDateController,
                              isDatePicker: true,
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            InputField(
                              hintText: 'Stock Symbol',
                              controller: stockSymbolController,
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            InputField(
                              hintText: 'Quantity',
                              controller: quantityController,
                            ),
                            const SizedBox(
                              height: 27,
                            ),
                            SubmitGradientButton(
                              buttonText: "Update",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  double? price = double.tryParse(investmentPriceController.text) ?? 0.0;
                                  double? quantity = double.tryParse(quantityController.text) ?? 0.0;
                                  if (price == null || quantity == null) {
                                    showSnackBar(context, "Price and Quantity must be valid numbers");
                                    return;
                                  }
                                  DateTime? investmentDate;
                                  try {
                                    if (investmentDateController.text.isNotEmpty) {
                                      investmentDate = DateTime.parse(investmentDateController.text);
                                    }
                                  } catch (e) {
                                    showSnackBar(context, "Invalid date format");
                                    return;
                                  }
                                  context.read<PortfolioBloc>().add(
                                      AddStockToPortfolioEvent(stockSymbol: stockSymbolController.text.trim(),
                                        investmentDate: investmentDate!,
                                        investmentPrice: price,
                                        quantity: quantity,
                                      ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ],
            ),
          )),
    );
  }
}
