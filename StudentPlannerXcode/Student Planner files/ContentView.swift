import SwiftUI

//главный контейнер
//создаётся общая ViewModel и настраиваются вкладки снизу

struct ContentView: View {
    
    //@StateObject создаёт ViewModel один раз
    //ViewModel передаётся на все экраны, поэтому данные в приложении общие
    @StateObject private var viewModel = StudentPlannerViewModel()

    var body: some View {
        //TabView создаёт нижнее меню с вкладками
        TabView {
            //главный экран
            NavigationStack {
                HomeView(viewModel: viewModel)
            }
            .tabItem {
                Label("Главная", systemImage: "house.fill")
            }

            //экран со списком задач
            NavigationStack {
                TasksView(viewModel: viewModel)
            }
            .tabItem {
                Label("Задачи", systemImage: "checklist")
            }

            //экран добавления новой задачи
            NavigationStack {
                AddTaskView(viewModel: viewModel)
            }
            .tabItem {
                Label("Добавить", systemImage: "plus.circle.fill")
            }

            //экран расписания
            NavigationStack {
                ScheduleView(viewModel: viewModel)
            }
            .tabItem {
                Label("Расписание", systemImage: "calendar")
            }

            //экран прогресса
            NavigationStack {
                RewardsView(viewModel: viewModel)
            }
            .tabItem {
                Label("Прогресс", systemImage: "trophy.fill")
            }
        }
    }
}
