import Foundation

class TaskFactory {

    let iso8601Formatter = {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")     // 日本時間（JST, +09:00）
        formatter.formatOptions = [
            .withInternetDateTime,      // "YYYY-MM-DDTHH:mm:ssZ"
            .withFractionalSeconds      // ミリ秒まで出力
        ]
        return formatter
    }()

    private func toUnixTimeSecondsString(_ date: Date) -> String {
        return String(Int(date.timeIntervalSince1970))
    }

    func createNewTask(title: String, deadline: String) -> Task {
        let createdAt = Date()
        let newTask = Task(
            id: toUnixTimeSecondsString(createdAt),
            title: title,
            deadline: deadline,
            isDone: false,
            createdAt: iso8601Formatter.string(from: createdAt)
        )
        return newTask
    }
}
