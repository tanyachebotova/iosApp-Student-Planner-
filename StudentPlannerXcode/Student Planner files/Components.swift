import SwiftUI

//содержит переиспользуемые компоненты интерфейса(чтобы не дублировать одинаковую верстку)

//компонент одной строки задачи
struct TaskRow: View {
    let task: PlannerTask
    let onToggle: () -> Void  //кложура (выполнение задачи)
    let onDelete: () -> Void  //кложура (удаление задачи)

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(task.isCompleted ? .green : .blue)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 5) {
                Text(task.title)
                    .fontWeight(.semibold)
                    .strikethrough(task.isCompleted)

                Text("\(task.deadline) • \(task.subject)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 3) {
                    ForEach(1...5, id: \.self) { number in
                        Image(systemName: number <= task.difficulty ? "star.fill" : "star")
                            .font(.caption2)
                            .foregroundStyle(.orange)
                    }
                }
            }

            Spacer()

            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

//компонент карточки достижения
//показывает иконку, название, описание и статус
struct AchievementCard: View {
    let achievement: Achievement

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: achievement.icon)
                .font(.title2)
                .foregroundStyle(achievement.isUnlocked ? .orange : .gray)
                .frame(width: 42, height: 42)
                .background(achievement.isUnlocked ? .orange.opacity(0.16) : .gray.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(achievement.title)
                    .fontWeight(.semibold)

                Text(achievement.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(achievement.isUnlocked ? "Получено" : "Закрыто")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(achievement.isUnlocked ? .green : .secondary)
        }
        .padding()
        .background(.gray.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//компонент карточки статистики (для отображения уровня и XP)
struct StatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)

            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
