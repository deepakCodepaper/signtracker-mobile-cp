import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesMultiPopup extends StatefulWidget {
  static const String route = '/update-sign-dialog';

  @override
  _FeaturesMultiPopupState createState() => _FeaturesMultiPopupState();
}

class _FeaturesMultiPopupState extends State<FeaturesMultiPopup> {
  List<String> _fruit = ['mel'];

  List<SmartSelectOption<String>> options = [
    SmartSelectOption<String>(value: 'active', title: 'Active'),
    SmartSelectOption<String>(value: 'pending', title: 'Inactive'),
    SmartSelectOption<String>(value: 'covered', title: 'Covered'),
    SmartSelectOption<String>(value: 'pending', title: 'Uncovered'),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(height: 7),
          SmartSelect<String>.multiple(
            title: 'Fruit',
            value: _fruit,
            isTwoLine: true,
            options: options,
            modalType: SmartSelectModalType.popupDialog,
            leading: Container(
              width: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.shopping_cart),
            ),
            onChange: (val) => setState(() => _fruit = val),
          ),
          Divider(indent: 20),
          SmartSelect<String>.multiple(
            title: 'Frameworks',
            value: _fruit,
            options: options,
            modalType: SmartSelectModalType.popupDialog,
            builder: (context, state, showOptions) {
              return ListTile(
                title: Text(state.title),
                subtitle: Text(
                  state.valueDisplay,
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(_fruit.length.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () => showOptions(context),
              );
            },
            onChange: (val) => setState(() => _fruit = val),
          ),
          Container(height: 7),
        ],
      ),
    );
  }
}
