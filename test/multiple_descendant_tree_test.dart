import 'package:multiple_descendant_tree/multiple_descendant_tree.dart';
import 'package:test/test.dart';



void main() {
  group('A group of tests', () {

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
      t.bfs([t.root], (x) => t.save(x));
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
      var n = t.load();
      print(n);
      print(t.toJson(n[0]));
    });

    test('remove(2)', () {
      counter = 0;
      final n = t.load();
      print(n);
      n[2].remove();
      print(t.toJson(n[0]));
    });
  });
}
