import SwiftUI

//экран с задачами
//здесь можно отметить задачу выполненной или удалить ее

struct TasksView: View {
    @ObservedObject var viewModel: StudentPlannerViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                //ForEach создает карточку для каждой задачи из массива
                ForEach(viewModel.tasks) { task in
                    TaskRow(
                        task: task,
                        
                        // кложура для изменения статуса задачи
                        onToggle: {
                            viewModel.toggleTask(task)
                        },
                        
                        // кложура для удаления задачи
                        onDelete: {
                            viewModel.deleteTask(task)
                        }
                    )
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Мои задачи")
    }
}
