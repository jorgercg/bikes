import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../keys.dart';
import '../list_items/list_item_widget.dart';
import '../../models/bike_model.dart';

Widget bikeListCard({
  @required Bike bike,
  @required BuildContext context,
  @required Function onEditCallback,
  @required Function onDeleteCallback,
  bool isDetailCard,
  bool isLastCard,
  String lastRouteName,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 4,
      right: 4,
      bottom: (isLastCard ?? false) ? 80 : 0,
    ),
    child: Card(
      key: AppKeys.bikeListItemCard(bike.bikeID),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExtendedImage.network(
              bike.bikePhotoURL,
              cache: true,
              mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  minScale: 0.9,
                  animationMinScale: 0.7,
                  maxScale: 3.0,
                  animationMaxScale: 3.5,
                  speed: 1.0,
                  inertialSpeed: 100.0,
                  initialScale: 1.0,
                  inPageView: false,
                  initialAlignment: InitialAlignment.center,
                );
              },
            ),
            ListItem(
              icon: Icon(FontAwesome.id_card),
              label: 'Name',
              text: bike.bikeName,
            ),
            Divider(
              height: 3,
            ),
            ListItem(
              icon: Icon(FontAwesome.list_ul),
              label: 'Category',
              text: bike.bikeCategory,
            ),
            Divider(
              height: 3,
            ),
            ListItem(
              icon: Icon(FontAwesomeIcons.textHeight),
              label: 'Frame Size',
              text: bike.bikeFrameSize,
            ),
            Divider(
              height: 3,
            ),
            ListItem(
              icon: Icon(MaterialIcons.location_city),
              label: 'Location',
              text: bike.bikeLocation,
            ),
            if (isDetailCard ?? false)
              Divider(
                height: 3,
              ),
            if (isDetailCard ?? false)
              ListItem(
                icon: Icon(Icons.attach_money),
                label: 'Price Range',
                text: bike.bikePriceRange,
              ),
            if (isDetailCard ?? false)
              Divider(
                height: 3,
              ),
            if (isDetailCard ?? false)
              ListItem(
                icon: Icon(Icons.description),
                label: 'Description',
                text: bike.bikeDescription,
              ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    onEditCallback(context, bike);
                  },
                ),
                FlatButton(
                  child: Icon(Icons.delete),
                  onPressed: () {
                    onDeleteCallback(
                      context,
                      bike.bikeID,
                      bike.bikeName,
                      lastRouteName,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
