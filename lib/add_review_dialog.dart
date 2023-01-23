import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReviewDialog extends StatelessWidget {
  const AddReviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    List<String> spinnerItems = ['1.0', '2.0', '3.0', '4.0', '5.0'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Column(
          children: [
            const Text('Avaliação :'),
            // const TextField(
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: 'Enter a search term',
            //   ),
            // ),
            Row(
              children: const [
                Text('Nota:'),
                // DropdownButton(
                //   value: dropdownValue,
                //   items: spinnerItems.map<DropdownMenuItem<String>>((value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (value) {},
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
