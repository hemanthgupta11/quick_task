import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'task_add_screen.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<ParseObject> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    setState(() {
      isLoading = true;
    });

    final currentUser = await ParseUser.currentUser() as ParseUser?;

    if (currentUser != null) {
      // Query tasks where 'user' equals the logged-in user
      final queryTasks = QueryBuilder<ParseObject>(ParseObject('Task'))
        ..whereEqualTo('user', currentUser);

      final response = await queryTasks.query();

      setState(() {
        isLoading = false;
        if (response.success && response.results != null) {
          tasks = response.results as List<ParseObject>;
        } else {
          tasks = [];
        }
      });
    } else {
      setState(() {
        isLoading = false;
        tasks = [];
      });
    }
  }

  Future<void> toggleTaskStatus(ParseObject task, bool newStatus) async {
    setState(() {
      isLoading = true;
    });

    task.set('isCompleted', newStatus);
    final response = await task.save();

    setState(() {
      isLoading = false;
    });

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task status updated successfully')),
      );
      fetchTasks(); // Refresh task list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task status')),
      );
    }
  }

  Future<void> deleteTask(ParseObject task) async {
    setState(() {
      isLoading = true;
    });

    final response = await task.delete();

    setState(() {
      isLoading = false;
    });

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task deleted successfully')),
      );
      fetchTasks();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task')),
      );
    }
  }

  Future<void> confirmDelete(ParseObject task) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () async {
              Navigator.pop(context); // Close the dialog
              await deleteTask(task); // Perform the delete action
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final user = await ParseUser.currentUser() as ParseUser?;
              if (user != null) {
                await user.logout();
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final isCompleted = task.get<bool>('isCompleted') ?? false;

              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: isCompleted,
                    onChanged: (bool? value) {
                      if (value != null) toggleTaskStatus(task, value);
                    },
                  ),
                  title: Text(
                    task.get<String>('title') ?? '',
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    'Due: ${task.get<DateTime>('dueDate')?.toLocal().toString().split(' ')[0] ?? 'N/A'}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTaskScreen(task: task),
                            ),
                          ).then((_) => fetchTasks()); // Refresh tasks after editing
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => confirmDelete(task),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskAddScreen()),
          );
          fetchTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
