import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class LoadFailWidget extends StatelessWidget {
  final String title;
  final VoidCallback reload;
  const LoadFailWidget({Key? key, required this.reload, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 17),
          ),
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  primary: Colors.green),
              onPressed: () async {
                reload();
              },
              child:  Text(tr('appConstants.tryAgain')))
        ],
      ),
    );
  }
}
