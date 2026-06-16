import SwiftUI
import Combine

// центральная логика приложения
// здесь хранятся задачи, прогресс, XP, уровень и достижения
// экраны отображают данные, ViewModel управляет их изменением

@MainActor
final class StudentPlannerViewModel: ObservableObject {
    //при изменении массива задач интерфейс обновится автоматически
    @Published var tasks: [PlannerTask] = [
        PlannerTask(title: "Сделать лабораторную работу", subject: "Programming", deadline: "Сегодня", difficulty: 3, isCompleted: false),
        PlannerTask(title: "Повторить новую тему", subject: "Math", deadline: "Завтра", difficulty: 2, isCompleted: false),
        PlannerTask(title: "Подготовить презентацию", subject: "DevOps", deadline: "Пятница", difficulty: 4, isCompleted: false),
        PlannerTask(title: "Оформить конспект", subject: "Biology", deadline: "На неделе", difficulty: 1, isCompleted: true)
    ]
    
    //текст совета дня на экране "Прогресс"
    @Published var motivationText = "Нажми кнопку, чтобы получить совет дня."
    //показывает, идёт ли сейчас загрузка совета
    @Published var isLoadingMotivation = false
    
    //количество выполненных задач
    var completedTasksCount: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    //общее количество XP
    var totalExperience: Int {
        tasks.filter { $0.isCompleted }.map { $0.difficulty * 25 }.reduce(0, +)
    }
    
    //доля выполненных задач
    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedTasksCount) / Double(tasks.count)
    }
    
    //уровень пользователя на основе XP
    var level: Int {
        max(1, totalExperience / 100 + 1)
    }
    
    //достижения (открываются автоматически по текущему прогрессу)
    var achievements: [Achievement] {
        [
            Achievement(title: "Первый шаг", description: "Закрыта хотя бы одна задача", icon: "checkmark.seal.fill", isUnlocked: completedTasksCount >= 1),
            Achievement(title: "Стабильность", description: "Выполнено минимум 3 задачи", icon: "flame.fill", isUnlocked: completedTasksCount >= 3),
            Achievement(title: "Новый уровень", description: "Набрано 100 XP", icon: "star.circle.fill", isUnlocked: totalExperience >= 100),
            Achievement(title: "Суперстудент", description: "Выполнены все задачи", icon: "crown.fill", isUnlocked: !tasks.isEmpty && completedTasksCount == tasks.count)
        ]
    }
    
    //функция добавления новой задачи в список(убираются лишние пробелы, а пустые поля заменяются стандартным текстом)
    func addTask(title: String, subject: String, deadline: String, difficulty: Int) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSubject = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDeadline = deadline.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else { return }
        
        let newTask = PlannerTask(
            title: trimmedTitle,
            subject: trimmedSubject.isEmpty ? "Без предмета" : trimmedSubject,
            deadline: trimmedDeadline.isEmpty ? "Без дедлайна" : trimmedDeadline,
            difficulty: difficulty,
            isCompleted: false
        )
        
        tasks.append(newTask)
    }
    
    //функция меняет статус задачи
    func toggleTask(_ task: PlannerTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isCompleted.toggle()
    }
    
    // функция удаляет задачу из массива по ее id
    func deleteTask(_ task: PlannerTask) {
            tasks.removeAll { $0.id == task.id }
        }
        
    // функция загрузки совета дня
    // используется async и await
    func loadMotivation() async {
        //включается состояние загрузки
        isLoadingMotivation = true
        motivationText = "Загрузка совета..."
        
        try? await Task.sleep(nanoseconds: 1_300_000_000) //задержка 1.3 секунды
        
        let advices = [
            "Закрой одну маленькую задачу, мозг любит быстрый успех.",
            "Поставь таймер и занимайся только одной задачей.",
            "Если задача кажется огромной, разбей её на маленькие подзадачи.",
            "Не жди идеальной мотивации. Начни прямо сейчас!"
        ]
        //выбирается случайный совет из массива
        motivationText = advices.randomElement() ?? "Сегодня хороший день, чтобы закрыть хотя бы одну задачу."
        //отключается состояние загрузки
        isLoadingMotivation = false
        }
    }
