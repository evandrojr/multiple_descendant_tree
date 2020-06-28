import 'package:multiple_descendant_tree/multiple_descendant_tree.dart';
import 'package:test/test.dart';

void main() {
  group('Main tests', () {
    final serialized = '''[
	{"id":"0", "data":"0", "children":[1, 2]},
	{"id":"1", "data":"1", "children":[3, 4]},
	{"id":"2", "data":"2", "children":[5, 6]},
	{"id":"3", "data":"3", "children":[]},
	{"id":"4", "data":"4", "children":[]},
	{"id":"5", "data":"5", "children":[]},
	{"id":"6", "data":"6", "children":[]}
]''';

    var counter = 0;
    final t = MultipleDescendantTree();

    Node nodeFactory() {
      return Node(children: <Node>[], id: counter++);
    }

    // setUp(() {
    //   // awesome = Awesome();
    // });

    test('First Test', () {
      expect(t.root.toString(), '0');
    });

    test('Add child', () {
      t.root.addChild(nodeFactory());
      // expect(t.root.addChild(nodeFactory()),);
    });

    test('bfs', () {
      counter = 0;
      MultipleDescendantTree.count = 0;
      t.root = nodeFactory();
      t.root.addChild(nodeFactory());
      t.root.addChild(nodeFactory());
      t.root.children[0].addChild(nodeFactory());
      t.root.children[0].addChild(nodeFactory());
      t.root.children[1].addChild(nodeFactory());
      t.root.children[1].addChild(nodeFactory());
      t.bfs([t.root], (x) => t.serialize(x));
    });

    test('toJson()', () {
      counter = 0;
      MultipleDescendantTree.count = 0;
      t.root = nodeFactory();
      t.root.addChild(nodeFactory());
      t.root.addChild(nodeFactory());
      t.root.children[0].addChild(nodeFactory());
      t.root.children[0].addChild(nodeFactory());
      t.root.children[1].addChild(nodeFactory());
      t.root.children[1].addChild(nodeFactory());
      // t.bfs([t.root], (x) {json = t.toJson(x));
      print(t.toJson(t.root));
    });

    test('load()', () {
      counter = 0;
      var n = t.load(serialized);
      print(n);
      print(t.toJson(n[0]));
    });

    test('remove(2)', () {
      counter = 0;
      final n = t.load(serialized);
      print(n);
      n[2].remove();
      print(t.toJson(n[0]));
    });
  });
}
