import Foundation

class TaskRepository {

    private let fileURL = URL(fileURLWithPath: "./Data/tasks.json")
    private let jsonEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }()
    private let jsonDecoder = JSONDecoder()

    private func loadTasksFromFile() -> [Task] {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            return try jsonDecoder.decode([Task].self, from: jsonData)
        } catch {
            print("エラー: \(error)")
            return []
        }
    }

    private func saveTasksToFile(_ tasks: [Task]) {
        do {
            let jsonData = try jsonEncoder.encode(tasks)
            try jsonData.write(to: fileURL)
        } catch {
            print("エラー: \(error)")
        }
    }

    func getAll() -> [Task] {
        let tasks = loadTasksFromFile()
        do {
            return try tasks.sorted(by: { task1, task2 throws in
                task1.createdAt < task2.createdAt
            })
        } catch {
            print("エラー: \(error)")
            return []
        }
    }

    func add(_ newTask: Task) {
        let tasks = loadTasksFromFile()
        let newTasks = tasks + [newTask]
        saveTasksToFile(newTasks)
    }
}
