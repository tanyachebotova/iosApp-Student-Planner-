import SwiftUI

//экран добавления новой задачи
//пользователь вводит название, предмет, дедлайн и выбирает сложность

struct AddTaskView: View {
    @ObservedObject var viewModel: StudentPlannerViewModel

    //@State хранит временные данные, они меняются при вводе текста пользователем
    @State private var title = ""
    @State private var subject = ""
    @State private var deadline = ""
    @State private var difficulty = 3
    @State private var showSavedMessage = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                //карточка с полями ввода
                VStack(spacing: 0) {
                    TextField("Название задачи", text: $title)
                        .padding(.vertical, 12)

                    Divider()

                    TextField("Предмет", text: $subject)
                        .padding(.vertical, 12)

                    Divider()

                    TextField("Дедлайн", text: $deadline)
                        .padding(.vertical, 12)

                    Divider()

                    Stepper("Сложность: \(difficulty)", value: $difficulty, in: 1...5)
                        .padding(.vertical, 12)
                }
                .padding(.horizontal, 16)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))

                //блок предпросмотра показывает, как будет выглядеть задача
                VStack(alignment: .leading, spacing: 10) {
                    Text("Предпросмотр")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(title.isEmpty ? "Новая задача" : title)
                            .font(.headline)

                        Text("\(subject.isEmpty ? "Без предмета" : subject) • \(deadline.isEmpty ? "Без дедлайна" : deadline)")
                            .foregroundStyle(.secondary)

                        Text("Награда: \(difficulty * 25) XP")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }

                Button {
                    // кложура кнопки (код выполняется после нажатия)
                    viewModel.addTask(title: title, subject: subject, deadline: deadline, difficulty: difficulty)
                    
                    //очищаем поля после добавления
                    title = ""
                    subject = ""
                    deadline = ""
                    difficulty = 3
                    
                    // сообщение об успешном добавлении
                    showSavedMessage = true
                    
                } label: {
                    Text("Добавить задачу")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }

                if showSavedMessage {
                    Text("Задача добавлена")
                        .foregroundStyle(.green)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Добавление")
    }
}
