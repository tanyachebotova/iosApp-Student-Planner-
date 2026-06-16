import SwiftUI

//экран расписания на день

struct ScheduleView: View {
    @ObservedObject var viewModel: StudentPlannerViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Сегодня")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 12)
                
                ForEach(viewModel.lessons) { lesson in
                    HStack(alignment: .top, spacing: 1) {
                        
                        //левая часть карточки: время и линия
                        VStack {
                            Text(lesson.time)
                                .font(.headline)

                            Circle()
                                .fill(.blue)
                                .frame(width: 10, height: 10)

                            Rectangle()
                                .fill(.blue.opacity(0.25))
                                .frame(width: 2, height: 45)
                        }
                        .frame(width: 62)

                        //правая часть карточки: предмет, преподаватель и аудитория
                        VStack(alignment: .leading, spacing: 8) {
                            Text(lesson.subject)
                                .font(.headline)

                            Text(lesson.teacher)
                                .foregroundStyle(.secondary)

                            Label(lesson.room, systemImage: "mappin.and.ellipse")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.gray.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Расписание")
    }
}
