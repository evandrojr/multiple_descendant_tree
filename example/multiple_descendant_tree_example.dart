import 'package:multiple_descendant_tree/multiple_descendant_tree.dart';

void main() {
  final serialized = '''[
	{"id":"0", "data":"0", "children":[1, 2]},
	{"id":"1", "data":"1", "children":[3, 4]},
	{"id":"2", "data":"2", "children":[5, 6]},
	{"id":"3", "data":"3", "children":[]},
	{"id":"4", "data":"4", "children":[]},
	{"id":"5", "data":"5", "children":[]},
	{"id":"6", "data":"6", "children":[]}
]''';

  final mdt = MultipleDescendantTree();
  var nodes = mdt.load(serialized);
  nodes.forEach((element) {
    print(element);
  });
  // print(mdt.root);
  // print(mdt);
}
