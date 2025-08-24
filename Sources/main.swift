import Foundation

let fileURL = URL(fileURLWithPath: "./Data/tasks.json")

func loadTasksFromFile() -> [Task] {
    do {
        let jsonData = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Task].self, from: jsonData)
    } catch {
        print("エラー: \(error)")
        return []
    }
}

func saveTasksToFile(_ tasks: [Task]) {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = [.prettyPrinted]
    do {
        let jsonData = try jsonEncoder.encode(tasks)
        try jsonData.write(to: fileURL)
    } catch {
        print("エラー: \(error)")
    }
}

let tasks = loadTasksFromFile()

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

    let formatter = ISO8601DateFormatter()
    formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")     // 日本時間（JST, +09:00）
    formatter.formatOptions = [
        .withInternetDateTime,      // "YYYY-MM-DDTHH:mm:ssZ"
        .withFractionalSeconds      // ミリ秒まで出力
    ]

    let createdAt = Date()
    let newTask = Task(
        id: String(Int(createdAt.timeIntervalSince1970)),
        title: newTaskTitleInput,
        deadline: newTaskDeadlineInput,
        isDone: false,
        createdAt: formatter.string(from: createdAt)
    )

    let newTasks = tasks + [newTask]
    saveTasksToFile(newTasks)

default:
    exit(0)
}
