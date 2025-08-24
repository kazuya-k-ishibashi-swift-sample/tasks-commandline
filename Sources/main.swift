import Foundation

let taskFactory = TaskFactory()
let taskRepository = TaskRepository()

let tasks = try taskRepository.getAll().sorted(by: { task1, task2 throws in
    task1.deadline < task2.deadline
})

print("""

    Tasks（\(tasks.count)件）：
    \(tasks.enumerated().map { index, task -> String in
        "\(String(format: "%2d", index + 1)). [\(task.isDone ? "x" : " ")] \(task.title)（期限：\(task.deadline)）"
    }.joined(separator: "\n"))

    """)

print("""
    Operation:
        [C]reate
    """)
print("> ", terminator: "")
let input: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

switch input.prefix(1).lowercased() {
case "c":
    print("""
        c... Create Task
        """)

    // create task process
    print("title: ", terminator: "")
    let newTaskTitleInput: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    print("deadline: ", terminator: "")
    let newTaskDeadlineInput: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

    let newTask = taskFactory.createNewTask(
        title: newTaskTitleInput,
        deadline: newTaskDeadlineInput
    )

    taskRepository.add(newTask)

default:
    exit(0)
}
