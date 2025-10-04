import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class MindMapScreen extends StatelessWidget {
  const MindMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Graph graph = Graph()..isTree = true;
    final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

    // Define nodes
    final root = Node.Id("История на Изкуствения Интелект");
    final turing = Node.Id("Начало на ИИ\n- Алън Тюринг (1950-те)\n- 'Могат ли машините да мислят?'");
    final cs = Node.Id("ИИ и компютърни науки\n- Хардуер, езици, алгоритми\n- Вълнуваща област");
    final mccarthy = Node.Id("Джон Маккарти\n- 'Интелигентни машини'\n- Възприемат, разсъждават, действат");
    final development = Node.Id("Развитие\n- От теория към практика\n- AGI няма още\n- Днешният ИИ = ANI");
    final examples = Node.Id("Примери днес\n- Асистенти\n- Лицево разпознаване\n- Самоуправляващи коли\n- GPT");

    // Build graph
    graph.addEdge(root, turing);
    graph.addEdge(root, cs);
    graph.addEdge(root, mccarthy);
    graph.addEdge(root, development);
    graph.addEdge(root, examples);

    builder
      ..siblingSeparation = (30)
      ..levelSeparation = (50)
      ..subtreeSeparation = (30)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Мисловна Карта"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.0,
        child: GraphView(
          graph: graph,
          algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
          builder: (Node node) {
            // Render each node as a card
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                node.key!.value as String,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}