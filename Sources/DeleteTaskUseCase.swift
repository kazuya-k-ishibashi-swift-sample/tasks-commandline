class DeleteTaskUseCase {

    private let taskRepository: TaskRepository

    init(
        taskRepository: TaskRepository
    ) {
        self.taskRepository = taskRepository
    }

    func callAsFunction() {
        print("number: ", terminator: "")
        let deletingTaskNumInput: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let deletingTaskNum = Int(deletingTaskNumInput)
        if (deletingTaskNum == nil) {
            return
        }


        do {
            let deletingTaskIndex = deletingTaskNum! - 1
            let tasks = try taskRepository.getAll().sorted(by: { task1, task2 throws in
                task1.deadline < task2.deadline
            })

            let deletingTask = tasks[deletingTaskIndex]

            taskRepository.delete(id: deletingTask.id)
        } catch {
            print("エラー: \(error)")
            return
        }
    }
}