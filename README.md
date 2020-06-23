A library for Dart developers.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:multiple_descendant_tree/multiple_descendant_tree.dart';

Examples:

    var counter = 0;
    final t = MultipleDescendantTree();

    Node nodeFactory() {
      return Node(children: <Node>[], id: counter++);
    }

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
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
# multiple_descendant_tree
# multiple_descendant_tree
