import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../blocs/search_bloc/search_bloc.dart';
import '../../blocs/search_bloc/search_event.dart';
import '../../blocs/search_bloc/search_state.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_string.dart';
import '../../constants/app_theme.dart';
import '../../injection_container.dart';
import '../../models/city.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/load_fail_widget.dart';

class SearchScreen extends StatefulWidget {
  final String cityName;

  const SearchScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String displayStringForOption(City city) => city.name;

class _SearchScreenState extends State<SearchScreen>
    with AfterLayoutMixin<SearchScreen> {
  final _locationBloc = AppDependencies.injector.get<SearchBloc>();

  @override
  void afterFirstLayout(BuildContext context) {
    AppDependencies.injector.get<SearchBloc>().add(SearchRequested());
  }

  @override
  Widget build(BuildContext context) {
    AppTheme _theme = AppTheme();
    TextStyle _titleAppBarStyle = _theme.lightTheme.textTheme.bodyText2!
        .copyWith(
            fontFamily: AppFont.fontHelveticaNeue,
            fontWeight: AppFontWeight.light,
            fontSize: 20,
            color: Colors.white);

    TextStyle _subTitleAppBarStyle = _theme.lightTheme.textTheme.bodyText2!
        .copyWith(
            fontFamily: AppFont.fontHelveticaNeue,
            fontSize: 18,
            color: ColorsApp.secondaryTextColor);
    TextEditingController _fieldTextEditingController = TextEditingController();

    return Scaffold(
        backgroundColor: ColorsApp.primaryBackgroundColor,
        appBar: CustomAppBar(
          title: Column(
            children: [
              Text(
                AppString.location,
                style: _titleAppBarStyle,
              ),
              Text(
                widget.cityName,
                style: _subTitleAppBarStyle,
              ),
            ],
          ),
          widgetLeading: TextButton(
            child: Text(AppString.done,
                style: _theme.lightTheme.textTheme.bodyText2!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.leadingTextColor)),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          bloc: _locationBloc,
          builder: (context, state) {
            if (state is SearchLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchLoadFailure) {
              return LoadFailWidget(
                  reload: () {
                    context.read<SearchBloc>().add(SearchRequested());
                  },
                  title: AppString.loadFailureText);
            } else if (state is SearchLoadSuccess) {
              return Container(
                color: ColorsApp.searchFieldColor,
                child: Autocomplete<City>(
                  displayStringForOption: displayStringForOption,
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
                              .contains(textEditingValue.text.toLowerCase()) ||
                          city.longitude
                              .toString()
                              .contains(textEditingValue.text);
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
                                    textStyle: _theme
                                        .lightTheme.textTheme.headline6!
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
