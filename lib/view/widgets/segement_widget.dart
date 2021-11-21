import 'package:flutter/cupertino.dart';

class CupertinoSegmentedControlDemo extends StatefulWidget {
  const CupertinoSegmentedControlDemo({Key key}) : super(key: key);

  @override
  _CupertinoSegmentedControlDemoState createState() =>
      _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<CupertinoSegmentedControlDemo> with RestorationMixin {
  RestorableInt currentSegment = RestorableInt(0);

  @override
  String get restorationId => 'cupertino_segmented_control';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(currentSegment, 'current_segment');
  }

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment.value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    const segmentedControlMaxWidth = 500.0;
    final children = <int, Widget>{
      0: Text("Sent"),
      1: Text("Pending"),
      2: Text("Accepted"),
    };

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text("title"),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              width: segmentedControlMaxWidth,
              child: CupertinoSegmentedControl<int>(
                children: children,
                onValueChanged: onValueChanged,
                groupValue: currentSegment.value,
              ),
            ),
            SizedBox(
              width: segmentedControlMaxWidth,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoSlidingSegmentedControl<int>(
                  children: children,
                  onValueChanged: onValueChanged,
                  groupValue: currentSegment.value,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              alignment: Alignment.center,
              child: children[currentSegment.value],
            ),
          ],
        ),
      ),
    );
  }
}
