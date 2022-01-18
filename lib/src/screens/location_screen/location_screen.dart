import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/injection_container.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/custom_app_bar.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../blocs/location/location_state.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_string.dart';
import '../../models/city.dart';
import '../../widgets/load_fail_widget.dart';

class LocationScreen extends StatefulWidget {
  final String cityName;

  const LocationScreen({Key? key, required this.cityName}) : super(key: key);

  static String displayStringForOption(City city) => city.name;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with AfterLayoutMixin<LocationScreen> {
  final _locationBloc = AppDependencies.injector.get<LocationBloc>();

  @override
  void afterFirstLayout(BuildContext context) {
    AppDependencies.injector.get<LocationBloc>().add(LocationRequested());
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    TextEditingController _fieldTextEditingController = TextEditingController();

    return Scaffold(
        backgroundColor: ColorsApp.primaryBackgroundColor,
        appBar: CustomAppBar(
          subtitle: widget.cityName,
          title: AppString.location,
          widgetLeading: TextButton(
            child: Text(AppString.done,
                style: _theme.textTheme.bodyText2!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.leadingTextColor)),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: BlocBuilder<LocationBloc, LocationState>(
          bloc: _locationBloc,
          builder: (context, state) {
            if (state is LocationLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationLoadFailure) {
              return LoadFailWidget(
                  reload: () {
                    context.read<LocationBloc>().add(LocationRequested());
                  },
                  title: AppString.loadFailureText);
            } else if (state is LocationLoadSuccess) {
              return Container(
                color: ColorsApp.searchFieldColor,
                child: Autocomplete<City>(
                  displayStringForOption: LocationScreen.displayStringForOption,
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    _fieldTextEditingController = controller;
                    return TextField(
                        cursorColor: ColorsApp.cursorColor,
                        autofocus: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search,
                                color: ColorsApp.searchIconColor),
                            suffixIcon: IconButton(
                                onPressed: () =>
                                    _fieldTextEditingController.clear(),
                                icon: const Icon(Icons.close,
                                    color: ColorsApp.searchFieldIconColor)),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: AppString.hintText),
                        controller: _fieldTextEditingController,
                        focusNode: focusNode,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 16, color: Colors.grey.shade400));
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<City>.empty();
                    }
                    return state.cities.where((City city) {
                      return city.name
                          .toString()
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  optionsViewBuilder: (context, onSelected, cities) {
                    return Material(
                      child: Container(
                        color: ColorsApp.primaryBackgroundColor,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final City city = cities.elementAt(index);
                            return ListTile(
                                onTap: () {
                                  Navigator.pop(context, city);
                                },
                                title: SubstringHighlight(
                                    text: city.name,
                                    term: _fieldTextEditingController.text,
                                    textStyle: _theme.textTheme.headline6!
                                        .copyWith(color: Colors.grey),
                                    textStyleHighlight: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)));
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                  thickness: 1,
                                  indent: 17,
                                  color: Colors.white),
                          itemCount: cities.length,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container(color: Colors.orange);
          },
        ));
  }
}
