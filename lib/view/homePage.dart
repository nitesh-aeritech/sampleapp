import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/services/core/dependencies.dart';
import 'package:thewarehouse/services/core/httpService.dart';
import 'package:thewarehouse/view/core/baseView.dart';
import 'package:thewarehouse/viewModel/homeViewModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getIt<HttpService>().init(context);
    return BaseView<HomeViewModel>(
        onModelReady: (model) {},
        builder: ((context, model, child) => Scaffold(
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Routes.truckPage,
                  );
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: const Text(appName),
              ),
              body: centerHintText(text: 'Press button to scan the box'),
            )));
  }
}
