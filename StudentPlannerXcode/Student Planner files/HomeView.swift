import SwiftUI

//главный экран
//показывает уровень, XP, прогресс дня и ближайшие задачи

struct HomeView: View {
    //получаем общую ViewModel из ContentView
    @ObservedObject var viewModel: StudentPlannerViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                Text("Выполняй учебные задачи, получай XP и открывай достижения.")
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 3)
                    .padding(.top, -10)

                //карточки статистики (уровень и XP)
                HStack(spacing: 14) {
                    StatCard(title: "Уровень", value: "\(viewModel.level)", icon: "bolt.fill")
                    StatCard(title: "XP", value: "\(viewModel.totalExperience)", icon: "star.fill")
                }

                //прогресс
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Прогресс дня")
                            .font(.headline)

                        Spacer()

                        Text("\(viewModel.completedTasksCount)/\(viewModel.tasks.count)")
                            .fontWeight(.semibold)
                    }

                    ProgressView(value: viewModel.progress)
                        .tint(.blue)

                    Text("Каждая выполненная задача увеличивает твой прогресс.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
                .background(.blue.opacity(0.10))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                //ближайшие задачи
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ближайшие задачи")
                        .padding(.top, 4)
                        .font(.headline)

                    //показываются первые 3 задачи
                    ForEach(viewModel.tasks.prefix(3)) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundStyle(task.isCompleted ? .green : .secondary)

                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .strikethrough(task.isCompleted)

                                Text("\(task.subject) • \(task.deadline)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                        }
                        .padding(14)
                        .background(.gray.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .contentShape(Rectangle())
                        
                        // кложура (при нажатии задача меняет статус)
                        .onTapGesture {
                            viewModel.toggleTask(task)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Главная")
    }
}
