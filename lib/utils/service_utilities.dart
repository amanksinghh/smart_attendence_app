import 'package:flutter/material.dart';

import '../dialogs/CustomProgressDialog.dart';

class ServiceUtils {
  bool isDialogShowing = false;

  /*
    Show error message
   */
  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade600,
      elevation: 0,
      duration: const Duration(seconds: 3),
    ));
  }

  /*
    Show success message
   */
  static showSuccessMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      duration: const Duration(seconds: 3),
    ));
  }

  expenseContainer(
      String time,
      String date,
      String details,
      String amount
      ){
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: kElevationToShadow[4]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Expenses",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Time - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: time,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Date - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: date,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Details - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)),
                  TextSpan(
                    text: details,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Amount - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: "Rs. $amount",
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),

        ],
      ),
    );
  }

  menuItems(String itemId, String itemName, String itemPrice) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemId,
            style: const TextStyle(fontSize: 20, color: Colors.black87,)),
        Text(itemName,
            style: const TextStyle(fontSize: 20, color: Colors.black87)),
        Text(
          itemPrice,
          style: const TextStyle(fontSize: 20, color: Colors.black87),
        )
      ],
    );
  }

  eventsContainer(
      String name,
      String date,
      String venue,
      String bookingID
      ){
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: kElevationToShadow[4]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Events",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Name - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: name,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Date - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: date,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Venue - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)),
                  TextSpan(
                    text: venue,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Booking ID - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: bookingID,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),

        ],
      ),
    );
  }

  leavesContainer(
      BuildContext context,
      String fromDate,
      String toDate,
      String reason,
      String leaveType,
      String status,
      bool approved
      ) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: kElevationToShadow[4]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Leave Application",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "From - ",
                    style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: fromDate,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "To - ",
                    style: TextStyle(fontSize: 14,color: Colors.blue)
          ),
                  TextSpan(
                    text: toDate,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Reason - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)),
                  TextSpan(
                    text: reason,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Type - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                    text: leaveType,
                    style: const TextStyle(color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Status - ",
                      style: TextStyle(fontSize: 14,color: Colors.blue)
                  ),
                  TextSpan(
                   text: status,
                    style:
                    TextStyle(color: approved ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ],
      ),
    );
  }

  showLoader(BuildContext context) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return const CustomProgressDialog();
          }).then((value) {
        isDialogShowing = false;
      });
    }
  }

  hideLoader(BuildContext context) {
    if (isDialogShowing) {
      Navigator.pop(context);
    }
  }

  showLogoutPopup(BuildContext context, Function onLogout) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            // To display the title it is optional
            content: const Text(
              "Are you sure",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            // Message which will be pop up on the screen
            // Action widget which will provide the user to acknowledge the choice
            actions: [
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  Navigator.pop(context);
                },
                // function used to perform after pressing the button
                child: const Text(
                  "No",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  onLogout();
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          );
        });
  }
}
