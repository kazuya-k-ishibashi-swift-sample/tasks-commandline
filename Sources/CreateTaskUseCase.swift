class CreateTaskUseCase {

    private let taskFactory: TaskFactory
    private let taskRepository: TaskRepository

    init(
        taskFactory: TaskFactory,
        taskRepository: TaskRepository
    ) {
        self.taskFactory = taskFactory
        self.taskRepository = taskRepository
    }

    func callAsFunction() {
        print("title: ", terminator: "")
        let newTaskTitleInput: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        print("deadline: ", terminator: "")
        let newTaskDeadlineInput: String = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let newTask = taskFactory.createNewTask(
            title: newTaskTitleInput,
            deadline: newTaskDeadlineInput
        )

        taskRepository.add(newTask)
    }
}