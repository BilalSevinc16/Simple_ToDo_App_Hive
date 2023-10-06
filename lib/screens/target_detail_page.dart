import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simple_todo_app/target.dart';

class TargetDetailPage extends StatefulWidget {
  final Target target;

  const TargetDetailPage({Key? key, required this.target}) : super(key: key);

  @override
  State<TargetDetailPage> createState() => _TargetDetailPageState();
}

class _TargetDetailPageState extends State<TargetDetailPage> {
  final _targetBox = Hive.box<Map>("target");
  RegisTarget _regisTarget = RegisTarget();
  List<RegisTarget> _regisTargets = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _regisTargets = widget.target.history;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.target.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Detail",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print(value);
                _regisTarget.detail = value;
              },
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (_regisTarget.detail.length > 3) {
                      _regisTargets.add(_regisTarget);
                      widget.target.history = _regisTargets;
                      _targetBox.put(widget.target.id, widget.target.toMap());
                      _regisTarget = RegisTarget();
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
                  for (RegisTarget regisTarget in _regisTargets)
                    Card(
                      child: ListTile(
                        title: Text(regisTarget.detail),
                        subtitle: Row(
                          children: [
                            const Spacer(),
                            Text(regisTarget.regisTime.toString()),
                            IconButton(
                              onPressed: () {
                                _regisTargets.remove(regisTarget);
                                setState(() {});
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
