import SwiftUI

//экран прогресса
//здесь показываются XP и уровень, совет дня и достижения

struct RewardsView: View {
    @ObservedObject var viewModel: StudentPlannerViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Уровень \(viewModel.level) • \(viewModel.totalExperience) XP")
                    .foregroundStyle(.secondary)
                
                //совет дня загружается асинхронно через async/await
                VStack(alignment: .leading, spacing: 12) {
                    Text("Совет дня")
                        .padding(.top, 4)
                        .font(.headline)

                    Text(viewModel.motivationText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.yellow.opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button {
                        Task {
                            await viewModel.loadMotivation()  //loadMotivation() – async-функция
                        }
                    } label: {
                        
                        HStack {
                            
                            //индикатор загрузки
                            if viewModel.isLoadingMotivation {
                                ProgressView()
                            }

                            Text(viewModel.isLoadingMotivation ? "Загрузка..." : "Загрузить совет")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isLoadingMotivation)
                }

                //блок достижений (открываются автоматически)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Достижения")
                        .padding(.top, 4)
                        .font(.headline)

                    ForEach(viewModel.achievements) { achievement in
                        AchievementCard(achievement: achievement)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Мой прогресс")
    }
}
