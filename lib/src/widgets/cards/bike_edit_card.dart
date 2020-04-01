import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../blocs/bike_edit_BLoC.dart';
import '../../models/bike_model.dart';
import '../fields/item_edit_field.dart';
import '../list_items/list_item_widget.dart';

Widget bikeEditCard({
  @required Bike bike,
  @required BuildContext context,
  @required BikeEditBloc bikeEditBloc,
  @required Function onSaveCallback,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          EditItem(
              icon: Icon(FontAwesome.id_card),
              editField: editField(
                text: bike.bikeName,
                label: 'Name',
                hint: 'Cube Reaction Hybrid EX 500',
                errorText: 'Name is either too short or too long',
                streamField: bikeEditBloc.name,
                changeFunctionField: bikeEditBloc.changeName,
              )),
          Divider(
            height: 3,
          ),
          EditItem(
              icon: Icon(FontAwesome.list_ul),
              editField: editField(
                text: bike.bikeCategory,
                label: 'Category',
                hint: 'Commuting',
                errorText: 'Category is either too short or too long',
                streamField: bikeEditBloc.category,
                changeFunctionField: bikeEditBloc.changeCategory,
              )),
          Divider(
            height: 3,
          ),
          EditItem(
              icon: Icon(FontAwesomeIcons.textHeight),
              editField: editField(
                text: bike.bikeFrameSize,
                label: 'Frame Size',
                hint: 'M',
                errorText: 'Frame Size is either too short or too long',
                streamField: bikeEditBloc.frameSize,
                changeFunctionField: bikeEditBloc.changeFrameSize,
              )),
          Divider(
            height: 3,
          ),
          EditItem(
              icon: Icon(MaterialIcons.location_city),
              editField: editField(
                text: bike.bikeLocation,
                label: 'Location',
                hint: 'Stuttgart',
                errorText: 'Location is either too short or too long',
                streamField: bikeEditBloc.location,
                changeFunctionField: bikeEditBloc.changeLocation,
              )),
          Divider(
            height: 3,
          ),
          EditItem(
              icon: Icon(FontAwesome.photo),
              editField: editField(
                text: bike.bikePhotoURL,
                label: 'PhotoURL',
                hint:
                    'https://images.internetstores.de/products//1066124/02/98ba28/Cube_Town_Hybrid_Pro_500_Easy_Entry_black_n_green[640x480].jpg?forceSize=true&forceAspectRatio=true&useTrim=true',
                errorText: 'PhotoURL is either too short or too long',
                streamField: bikeEditBloc.photoURL,
                changeFunctionField: bikeEditBloc.changePhotoURL,
              )),
          Divider(
            height: 3,
          ),
          EditItem(
              icon: Icon(Icons.attach_money),
              editField: editField(
                text: bike.bikePriceRange,
                label: 'Price Range',
                hint: 'Normal',
                errorText: 'Price Range is either too short or too long',
                streamField: bikeEditBloc.priceRange,
                changeFunctionField: bikeEditBloc.changePriceRange,
              )),
          Divider(
            height: 3,
          ),
          EditItem(
              icon: Icon(Icons.description),
              editField: editField(
                text: bike.bikeDescription,
                label: 'Description',
                hint: 'Great bike for doing sports or riding in mountains.',
                errorText: 'Description is either too short or too long',
                streamField: bikeEditBloc.description,
                changeFunctionField: bikeEditBloc.changeDescription,
              )),
          Divider(
            height: 3,
          ),
          ButtonBar(
            children: <Widget>[
              StreamBuilder<bool>(
                stream: bikeEditBloc.saveValid,
                builder: (context, snapshot) {
                  return FlatButton(
                    child: Icon(Icons.save),
                    onPressed: snapshot.hasData
                        ? () => bikeEditBloc.submit(
                              onSaveCallback,
                              context,
                              null,
                              false,
                            )
                        : null,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
