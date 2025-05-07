import SwiftUI

struct Question {
    let question: String
    let options: [String]
    let answer: String
}

struct QuizPage: View {
    let questions = [
        Question(question: "How many leaves on a clover?", options: ["4", "3", "5", "6"], answer: "4"),
        Question(question: "What color symbolizes luck?", options: ["Blue", "Red", "Green", "Yellow"], answer: "Green"),
        Question(question: "In which country is clover lucky?", options: ["USA", "Ireland", "Japan", "France"], answer: "Ireland"),
        Question(question: "Which plant symbolizes good luck?", options: ["Clover", "Rose", "Lily", "Tulip"], answer: "Clover"),
        Question(question: "What color is associated with luck?", options: ["Red", "Green", "Blue", "Yellow"], answer: "Green"),
        Question(question: "What item attracts good luck?", options: ["Horseshoe", "Key", "Coin", "Ring"], answer: "Horseshoe"),
        Question(question: "What day is the luckiest?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Thursday"),
        Question(question: "What symbol attracts good luck?", options: ["Cross", "Star", "Heart", "Triangle"], answer: "Star"),
        Question(question: "What month is lucky for ventures?", options: ["January", "February", "March", "April"], answer: "March"),
        Question(question: "What item attracts good luck?", options: ["Bracelet", "Ring", "Pendant", "Watch"], answer: "Pendant"),
        Question(question: "What color attracts luck in Feng Shui?", options: ["Red", "Green", "Blue", "Yellow"], answer: "Red"),
        Question(question: "What item is under a pillow?", options: ["Coin", "Key", "Ring", "Stone"], answer: "Coin"),
        Question(question: "What day is the unluckiest?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Monday"),
        Question(question: "What item hangs above the door?", options: ["Horseshoe", "Key", "Coin", "Ring"], answer: "Horseshoe"),
        Question(question: "What color is lucky in China?", options: ["Red", "Green", "Blue", "Yellow"], answer: "Red"),
        Question(question: "What attracts luck in Japan?", options: ["Horseshoe", "Key", "Hotei Coin", "Hotei Ring"], answer: "Hotei Coin"),
        Question(question: "What day is lucky for weddings?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Thursday"),
        Question(question: "What attracts luck in India?", options: ["Horseshoe", "Key", "Ankush", "Ring"], answer: "Ankush"),
        Question(question: "What color is lucky in Ireland?", options: ["Red", "Green", "Blue", "Yellow"], answer: "Green"),
        Question(question: "What attracts luck in Russia?", options: ["Horseshoe", "Key", "Coin", "Ring"], answer: "Horseshoe"),
        Question(question: "What day is lucky for projects?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Wednesday"),
        Question(question: "What attracts luck in Europe?", options: ["Horseshoe", "Key", "Coin", "Ring"], answer: "Horseshoe"),
        Question(question: "What day is lucky for finances?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Wednesday"),
        Question(question: "What attracts luck in South America?", options: ["Horseshoe", "Key", "Amulet", "Ring"], answer: "Amulet"),
        Question(question: "What day is lucky for travel?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Thursday"),
        Question(question: "What attracts luck in North America?", options: ["Horseshoe", "Key", "Amulet", "Ring"], answer: "Amulet"),
        Question(question: "What day is lucky for romance?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Wednesday"),
        Question(question: "What attracts luck in Australia?", options: ["Horseshoe", "Key", "Amulet", "Ring"], answer: "Amulet"),
        Question(question: "What amulet symbolizes luck in Egypt?", options: ["Eye of Horus", "Pentagram", "Scepter", "Ankh"], answer: "Eye of Horus"),
        Question(question: "What symbol is lucky in Feng Shui?", options: ["Dragon", "Lotus", "Butterfly", "Cat"], answer: "Dragon"),
        Question(question: "What day is lucky for contracts?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Tuesday"),
        Question(question: "What color is lucky in Japan?", options: ["Red", "Green", "Blue", "Black"], answer: "Red"),
        Question(question: "What day is lucky to study?", options: ["Monday", "Tuesday", "Wednesday", "Thursday"], answer: "Monday"),
        Question(question: "What talisman brings luck in Africa?", options: ["Horseshoe", "Stone", "Amulet", "Ancient symbol"], answer: "Amulet"),
        Question(question: "What brings luck in Arab countries?", options: ["Horseshoe", "Stone", "Wonder Stone", "Incense"], answer: "Wonder Stone")
    ]

    
    @State private var shuffledQuestions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var gameOver = false
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        _shuffledQuestions = State(initialValue: questions.shuffled())
    }

    func handleAnswer(selectedOption: String) {
        if selectedOption == shuffledQuestions[currentQuestionIndex].answer {
            score += 1
        }
        
        if currentQuestionIndex < shuffledQuestions.count - 1 {
            currentQuestionIndex += 1
        } else {
            gameOver = true
            UserDefaults.standard.set(score, forKey: "quizScore")
        }
    }
    
    func resetGame() {
        shuffledQuestions = questions.shuffled()
        currentQuestionIndex = 0
        score = 0
        gameOver = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                var isLandscape = geometry.size.width > geometry.size.height
                
                
                    
                
                ZStack {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        HStack {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .onTapGesture {
                                    NavGuard.shared.currentScreen = .MENU
                                }
                            Spacer()
                       
                        }
                        Spacer()
                    }
                    
                    VStack {
                        if gameOver {
                            WinView2(score: score, totalQuestions: shuffledQuestions.count)
                               // .opacity(!isLandscape ? 1 : 0)
                        } else {
                            QuizView(question: shuffledQuestions[currentQuestionIndex], handleAnswer: handleAnswer)
                                .opacity(isLandscape ? 1 : 0)
                        }
                    }
                    .padding()
                    
                }
                
                LottieView(filename: "RotateDevice", contentMode: .scaleAspectFit, playReverse: true)
                    .frame(width: 200, height: 200)
                    //.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .opacity(!isLandscape ? 1 : 0)
                    .shadow(color: .white, radius: 10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarBackButtonHidden()
    
    }
}

struct QuizView: View {
    let question: Question
    let handleAnswer: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            
           
        
                
                
                VStack {
                    // Вопрос с фоновым изображением
                    ZStack {
                        // Фоновое изображение
                        Image("frame_for_question")
                            .resizable()
                            .scaledToFill() // Заполняет доступное пространство, сохраняя пропорции
                            .frame(width: geometry.size.width * 0.7, height: 220) // Ширина 90% от экрана, высота 150 (можно подстроить под нужды)
                        
                        // Текст вопроса
                        Text(question.question)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(10) // Внутренний отступ
                            .multilineTextAlignment(.center) // Центрирование текста
                    }
                    .frame(width: geometry.size.width * 0.9) // Ограничиваем ширину блока с текстом 90% от экрана
                    
                    
                    // Кнопки ответа
                    VStack(spacing: 5) {
                        // Первая строка с двумя вариантами ответов
                        HStack() {
                            ForEach(0..<2) { index in
                                if index < question.options.count {
                                    Button(action: {
                                        handleAnswer(question.options[index])
                                    }) {
                                        Text(question.options[index])
                                            .font(.title2)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Image("frame_for_answer") // Изображение фона для кнопок
                                                    .resizable()
                                                    .scaledToFit()
                                                    .clipped()
                                            )
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    .frame(height: 60) // Устанавливаем фиксированную высоту кнопок
                                }
                            }
                        }
                        // Вторая строка с двумя вариантами ответов
                        HStack() {
                            ForEach(2..<4) { index in
                                if index < question.options.count {
                                    Button(action: {
                                        handleAnswer(question.options[index])
                                    }) {
                                        Text(question.options[index])
                                            .font(.title2)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Image("frame_for_answer") // Изображение фона для кнопок
                                                    .resizable()
                                                    .scaledToFit()
                                                    .clipped()
                                            )
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    .frame(height: 60) // Устанавливаем фиксированную высоту кнопок
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20) // Отступы по бокам для кнопок
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               
            
        }
    }
    
}

struct GameOverView: View {
    let score: Int
    let totalQuestions: Int
    let resetGame: () -> Void
    
    
    var body: some View {
        VStack {
            Text("Game Over!")
                .font(.largeTitle)
                .bold()
            
            Text("You answered \(score) out of \(totalQuestions) correctly.")
                .font(.title2)
                .padding()   
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
    }
}


struct WinView2: View {
    let score: Int
    let totalQuestions: Int
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.win)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(1.25)
                    .overlay(
                        ZStack {
                            Text("\(score)")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(Font.system(size: 30))
                                .padding(.top, 80)
                        }
                    )
                    .onTapGesture {
                        NavGuard.shared.currentScreen = .MENU
                    }
            }
        }
    }
}

struct QuizPage_Previews: PreviewProvider {
    static var previews: some View {
        QuizPage()
    }
}
