import SwiftUI

// Модель учебной задачи.
struct PlannerTask: Identifiable {
    let id = UUID()          // id задачи
    var title: String        // название задачи
    var subject: String      // предмет
    var deadline: String     // дедлайн
    var difficulty: Int      // сложность задачи от 1 до 5
    var isCompleted: Bool    // выполнена задача или нет
}

// Модель достижения
// Достижение может быть открыто или закрыто в зависимости от прогресса
struct Achievement: Identifiable {
    let id = UUID()
    let title: String        // название достижения
    let description: String  // описание достижения
    let icon: String         // иконка
    let isUnlocked: Bool     // открыто достижение или нет
}
