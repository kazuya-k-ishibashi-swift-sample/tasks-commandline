import Foundation

let tasks = [
    Task(
        id: "001",
        title: "タスクA",
        deadline: "2025-08-02",
        isDone: false,
        createdAt: "2025-08-01T10:15:30.555+09:00"
    ),
    Task(
        id: "002",
        title: "タスクB",
        deadline: "2025-08-03",
        isDone: false,
        createdAt: "2025-08-01T15:20:35.555+09:00"
    ),
    Task(
        id: "003",
        title: "タスクC",
        deadline: "2025-08-04",
        isDone: false,
        createdAt: "2025-08-02T03:40:03.555+09:00"
    )
]

print("""

    Tasks（\(tasks.count)件）：
    \(tasks.enumerated().map { index, task -> String in
        "\(String(format: "%2d", index + 1)). [\(task.isDone ? "x" : " ")] \(task.title)（期限：\(task.deadline)）"
    }.joined(separator: "\n"))
    """)
