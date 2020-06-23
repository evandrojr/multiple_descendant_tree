import 'dart:collection';

import 'dart:convert';

class MultipleDescendantTree {
  static var count = 0;
  Node root = Node(children: <Node>[], data: 'root');

  String toJson(Node root) {
    var json = '[\n';
    bfs([root], (node) {
      json += '\t' + save(node) + ',\n';
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

  String save(Node node) {
    var children = [];
    node.children.forEach((element) {
      children.add(json.encode(element.id));
    });
    ;
    final saved =
        '{"id":"${node.id}", "data":"${node.data}", "children":$children}';
    return saved;
  }

  List<Node> load() {
    final saved = '''[
	{"id":"0", "data":"0", "children":[1, 2]},
	{"id":"1", "data":"1", "children":[3, 4]},
	{"id":"2", "data":"2", "children":[5, 6]},
	{"id":"3", "data":"3", "children":[]},
	{"id":"4", "data":"4", "children":[]},
	{"id":"5", "data":"5", "children":[]},
	{"id":"6", "data":"6", "children":[]}
]''';

    final  nodesMapList = json.decode(saved);
    final nodes = <Node>[];
    nodesMapList.forEach((nodeMap) {
      var node = Node(id: int.parse(nodeMap['id']), data: nodeMap['data']); 
      nodeMap['children'].forEach((childId){
        node.childrenIds.add(childId);
      }); 
      nodes.add(node);
    });
    nodes.forEach((node1) {
      nodes.forEach((node2) {
        
        if(node1.childrenIds.contains(node2.id)){
          node1.addChild(node2);
        }
      });
    });

    return nodes;
  }

  // @override
  // String toString() {
  //   root.children.forEach((element) {
  //     print(element);
  //   });

  //   return id.toString();
  // }
}

class Node {
  Node parent;
  List<Node> children= <Node>[];
  var id;

  final childrenIds = <int>[];

  @override
  String toString() {
    // print(data);
    return id.toString();
  }

  dynamic data;

  Node({List<Node> children, dynamic data='', int id = -1}) {
    if (id != -1) {
      this.id = id;
    } else {
      this.id = MultipleDescendantTree.count++;
    }
    if(children!=null){
      this.children = children;
    }else{
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
