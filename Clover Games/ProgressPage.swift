import SwiftUI

struct ProgressPage: View {

    // Прогресс для каждого блока
    @State private var progress1 = "0/100"  // Прогресс для бонусных игр
    @State private var progress2 = "0/100" // Прогресс для монет (инициализируем с 0)
    @State private var progress3 = "0/10"   // Прогресс для квиза
    
    @State private var collectedCoins = 0  // Количество собранных монет
    @State private var level2 = 1          // Уровень для монет (Level 2)
    
    @State private var completedBonusGames = 0  // Количество завершённых бонусных игр
    @State private var bonusGameLevel = 1        // Уровень бонусных игр (Level 1)
    
    @State private var correctAnswers = 0  // Количество правильных ответов в квизе
    @State private var quizLevel = 1       // Уровень квиза

    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                VStack {
                    HStack {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding()
                            .onTapGesture {
                                NavGuard.shared.currentScreen = .MENU
                            }
                        Spacer()
                    }
                    Spacer()
                }

                

                 
                    VStack {
                        Spacer()
                        ProgressBlock(imagePath: "prog1", progressText: $progress1, level: "\(level2)")
                        
                        ProgressBlock(imagePath: "prog2", progressText: $progress2, level: "\(quizLevel)")
                        
                        ProgressBlock(imagePath: "prog3", progressText: $progress2, level: "\(bonusGameLevel)")
                    }
                

              
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(
                Image(.backgroundMenu)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )

        }
        .onAppear {
            // Загружаем данные из UserDefaults
            loadCollectedCoins()
            loadCompletedBonusGames()
            loadCorrectAnswers()  // Загрузка количества правильных ответов
            updateProgressForLevel2()
            updateProgressForBonusGames()
            updateProgressForQuiz()  // Обновляем прогресс квиза
        }
        .onChange(of: collectedCoins) { newValue in
            updateProgressForLevel2()
        }
        .onChange(of: completedBonusGames) { newValue in
            updateProgressForBonusGames()
        }
        .onChange(of: correctAnswers) { newValue in
            updateProgressForQuiz()  // Обновляем прогресс квиза
        }
    }

    // Обновляем прогресс для Level 2 (монеты)
    func updateProgressForLevel2() {
        // Прогресс монет в блоке 2
        progress2 = "\(collectedCoins % 100)/100"  // Отображаем количество монет для текущего уровня
        
        // Уровень для монет (каждые 100 монет — новый уровень)
        level2 = (collectedCoins / 100) + 1
    }

    // Обновляем прогресс для бонусных игр с уровнями
    func updateProgressForBonusGames() {
        // Прогресс бонусных игр
        progress1 = "\(completedBonusGames)/10"  // Отображаем количество завершённых бонусных игр
        
        // Уровень бонусных игр (каждые 10 бонусных игр — новый уровень)
        bonusGameLevel = (completedBonusGames / 10) + 1
    }

    // Обновляем прогресс для квиза
    func updateProgressForQuiz() {
        progress3 = "\(correctAnswers)/1"  // Отображаем количество правильных ответов для текущего уровня
        quizLevel = (correctAnswers / 1) + 1  // Пример: уровень квиза увеличивается с каждым правильным ответом
    }

    // Загружаем количество собранных монет из UserDefaults
    func loadCollectedCoins() {
        if let savedBonusGames = UserDefaults.standard.value(forKey: "completedBonusGames") as? Int {
            completedBonusGames = savedBonusGames
        }
    }
    
    // Загружаем количество завершённых бонусных игр из UserDefaults
    func loadCompletedBonusGames() {
        if let savedCoins = UserDefaults.standard.value(forKey: "collectedCoins") as? Int {
            collectedCoins = savedCoins
        }
    }
    
    // Загружаем количество правильных ответов из UserDefaults
    func loadCorrectAnswers() {
        if let savedAnswers = UserDefaults.standard.value(forKey: "correctAnswers") as? Int {
            correctAnswers = savedAnswers
        }
    }

    // Функция для увеличения количества правильных ответов
    func incrementCorrectAnswer() {
        correctAnswers += 1
        UserDefaults.standard.set(correctAnswers, forKey: "correctAnswers")
    }
}

#Preview {
    ProgressPage()
}
