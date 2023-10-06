import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simple_todo_app/screens/target_detail_page.dart';
import 'package:simple_todo_app/target.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _targetBox = Hive.box<Map>("target");
  Target _target = Target();
  List<Target> _targets = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _targets = _targetBox.values.map((e) => Target.fromMap(e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Target Title",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print(value);
                _target.title = value;
              },
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (_target.title.length > 3) {
                      _targets.add(_target);
                      _targetBox.put(_target.id, _target.toMap());
                      _target = Target();
                      _controller.clear();
                      setState(() {});
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  for (Target target in _targets)
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TargetDetailPage(
                                target: target,
                              ),
                            ),
                          );
                        },
                        title: Text(target.title),
                        subtitle: Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                _target = target;
                                _controller.text = target.title;
                                _targets.remove(target);
                                setState(() {});
                              },
                              child: const Text(
                                "Edit Title",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _targets.remove(target);
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
