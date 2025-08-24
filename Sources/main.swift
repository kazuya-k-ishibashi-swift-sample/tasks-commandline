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

    // TODO: create task process

default:
    exit(0)
}
