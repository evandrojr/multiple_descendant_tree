import 'dart:collection';

import 'dart:convert';

class MultipleDescendantTree {
  static var count = 0;
  Node root = Node(children: <Node>[], data: 'root');

  String toJson(Node root) {
    var json = '[\n';
    bfs([root], (node) {
      json += '\t' + serialize(node) + ',\n';
    });
    // Removes the last comma
    json = json.substring(0, json.lastIndexOf(','));
    json += '\n]';
    return json;
  }

  ///     0
  ///   1  2
  /// 3 4  5 6
  void bfs(List<Node> nodes, Function actionOnVisit) {
    if (nodes.isEmpty) {
      return;
    } else {
      final nodesToVisit = <Node>[];
      for (var i = 0; i < nodes.length; i++) {
        var node = nodes[i];
        actionOnVisit(node);
        node.children.forEach((child) {
          nodesToVisit.add(child);
        });
      }
      bfs(nodesToVisit, actionOnVisit);
    }
  }

  String serialize(Node node) {
    var children = [];
    node.children.forEach((element) {
      children.add(json.encode(element.id));
    });
    ;
    final serialized =
        '{"id":"${node.id}", "data":"${node.data}", "children":$children}';
    return serialized;
  }

  List<Node> load(String serialized) {
    final nodesMapList = json.decode(serialized);
    final nodes = <Node>[];
    nodesMapList.forEach((nodeMap) {
      var node = Node(id: int.parse(nodeMap['id']), data: nodeMap['data']);
      nodeMap['children'].forEach((childId) {
        node.childrenIds.add(childId);
      });
      nodes.add(node);
    });
    nodes.forEach((node1) {
      nodes.forEach((node2) {
        if (node1.childrenIds.contains(node2.id)) {
          node1.addChild(node2);
        }
      });
    });

    root = nodes[0];
    return nodes;
  }

  @override
  String toString() {
    var text = root.data.toString() + '\n';
    root.children.forEach((element) {
      text += element.data + '\n';
    });
    return text;
  }
}

class Node {
  Node parent;
  List<Node> children = <Node>[];
  var id;

  final childrenIds = <int>[];

  @override
  String toString() {
    // print(data);
    var text = 'id: ${id.toString()} \n';
    text += 'data: ${data.toString()}\n';
    children.forEach((child) {
      text += 'child: ${child.id}\n';
    });
    // text += '\n';
    return text;
  }

  dynamic data;

  Node({List<Node> children, dynamic data = '', int id = -1}) {
    if (id != -1) {
      this.id = id;
    } else {
      this.id = MultipleDescendantTree.count++;
    }
    if (children != null) {
      this.children = children;
    } else {
      children = <Node>[];
    }
    this.data = data;
  }

  // Insert after
  void addChild(Node child) {
    child.parent = this;
    children.add(child);
  }

  void remove() {
    parent.children.addAll(children);
    parent.children.remove(this);
    // Do something do remove node from memory
  }
}
