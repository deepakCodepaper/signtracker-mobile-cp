import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesMultiPopup extends StatefulWidget {
  static const String route = '/update-sign-dialog';

  @override
  _FeaturesMultiPopupState createState() => _FeaturesMultiPopupState();
}

class _FeaturesMultiPopupState extends State<FeaturesMultiPopup> {
  List<String> _fruit = ['mel'];

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'active', title: 'Active'),
    S2Choice<String>(value: 'pending', title: 'Inactive'),
    S2Choice<String>(value: 'covered', title: 'Covered'),
    S2Choice<String>(value: 'pending', title: 'Uncovered'),
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
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isTwoLine: true,
                leading: Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.shopping_cart),
                ),
              );
            },
            choiceItems: options,
            modalType: S2ModalType.popupDialog,
            onChange: (state) => setState(() => _fruit = state.value),
          ),
          Divider(indent: 20),
          SmartSelect<String>.multiple(
            title: 'Frameworks',
            value: _fruit,
            choiceItems: options,
            modalType: S2ModalType.popupDialog,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                title: Text(
                  state.title,
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                value: state.valueDisplay,
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(_fruit.length.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () => state.showModal(),
              );
            },
            onChange: (state) => setState(() => _fruit = state.value),
          ),
          Container(height: 7),
        ],
      ),
    );
  }
}
