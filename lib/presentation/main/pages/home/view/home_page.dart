import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../app/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores()
      ],
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<BannerAd>>(
        stream: _viewModel.outputBanners,
        builder: (context, snapshot) {
          return _getBannerWidget(snapshot.data);
        });
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(banner.image, fit: BoxFit.cover),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s90,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getServices() {
    return Center();
  }

  Widget _getStores() {
    return Center();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
