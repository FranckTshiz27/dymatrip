import 'package:flutter/material.dart';
import 'package:training_dyma_training_exercice/models/activity.model.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final bool isSelected;
  final VoidCallback toggleActivity;

  const ActivityCard(
      {super.key,
      required this.activity,
      required this.isSelected,
      required this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Ink.image(
              // image: AssetImage(activity.image),
              image: NetworkImage(activity.image!),
              fit: BoxFit.cover,
              child: InkWell(
                onTap: toggleActivity,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.white,
                        )
                    ],
                  )),
                  Row(
                    children: [
                      // Text(
                      //   activity.name,
                      //   style:
                      //       const TextStyle(color: Colors.white, fontSize: 15),
                      // )
                      Flexible(
                          flex: 1,
                          child: FittedBox(
                            child: Text(
                              activity.name!,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ));

    // return ListTile(
    //   // leading: Image.asset(
    //   //   activity.image,
    //   //   width: 100,
    //   // ),
    //   leading: CircleAvatar(backgroundImage: AssetImage(activity.image)),
    //   title: Text(activity.name),
    //   subtitle: Text(activity.city),
    //   contentPadding: const EdgeInsets.all(0),
    //   trailing: Checkbox(
    //       value: true,
    //       tristate: true,
    //       activeColor: Colors.black,
    //       checkColor: Colors.red,
    //       onChanged: (e) {}),
    // );
  }
}
