import Foundation

let taskFactory = TaskFactory()
let taskRepository = TaskRepository()
let createTaskUseCase = CreateTaskUseCase(
    taskFactory: taskFactory,
    taskRepository: taskRepository
)
let deleteTaskUseCase = DeleteTaskUseCase(
    taskRepository: taskRepository
)

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
        [C]reate / [D]elete
    """)
print("> ", terminator: "")
let input: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

switch input.prefix(1).lowercased() {
case "c":
    print("""
        c... Create Task
        """)
    createTaskUseCase()

case "d":
    print("""
        d... Delete Task
        """)
    deleteTaskUseCase()

default:
    exit(0)
}
