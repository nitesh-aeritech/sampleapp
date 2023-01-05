import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:thewarehouse/services/core/dependencies.dart';
import 'package:thewarehouse/viewModel/core/baseViewModel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  final void Function(T)? onModelReady;
  final void Function(T)? onDispose;
  final void Function(T)? reAssemble;

  const BaseView({
    Key? key,
    required this.builder,
    this.onModelReady,
    this.onDispose,
    this.reAssemble,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late final T model = getIt<T>();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    model.initializeContext(context);
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    // });

    super.initState();
  }

  @override
  void dispose() async {
    model.disMountWidget();
    super.dispose();
    if (widget.onDispose != null) {
      widget.onDispose!(model);
    }
  }

  @override
  void reassemble() {
    if (widget.reAssemble != null) {
      widget.reAssemble!(model);
    }
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => model,
      child: Consumer<T>(builder: ((context, value, child) => widget.builder(context, value, child))),
    );
  }
}
