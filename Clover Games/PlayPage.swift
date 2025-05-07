import SwiftUI
import SpriteKit

struct PlayPage: View {
    @State private var gameScene: GameScene? = nil
    @State private var bonusGameScene: BonusGameScene? = nil
    @State private var score: Int = 0
    @State private var gameOver: Bool = false
    @State private var isBonusGameActive: Bool = false  // Это состояние контролирует бонусную игру
    @State private var showPrizImage: Bool = false // New state for showing the "priz" image

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
               
                
                
                if showPrizImage {
                    Image("priz")
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(1.2)
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                
                // Если бонусная игра активна, показываем её
                if isBonusGameActive {
                    BonusGameView(scene: bonusGameScene)
                } else {
                    // Отображение основной игры
                    ZStack {
                        
                        GameView(scene: gameScene)
                    }
                        
                    
                        
                }
                
                // Экран Game Over
                if gameOver {
                    ZStack {
                        WinView(score: $score)
                    }
                }
                
                // Show "priz" image if active
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
                        ScoreTemplate(score: $score)
                    }
                    Spacer()
                }
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
            
        }
        .background (
            Image(isBonusGameActive ? "background"  : "backgroundGame")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                .scaleEffect(1.1)
//                .opacity(isBonusGameActive ? 0.6 : 1)
                
            )
                    .onAppear {
                        setupGameScene()
                    }
                }
    
    func setupGameScene() {
        // Настройка основной сцены
        let scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .resizeFill
        
        scene.gameOverHandler = {
            self.gameOver = true
        }
        scene.scoreUpdateHandler = { score in
            self.score = score
        }
        scene.bonusGameHandler = {
            self.startBonusGame()
        }
        
        gameScene = scene
    }
    
    
    func startBonusGame() {
        // Запуск бонусной игры, если она еще не была активна
        if !isBonusGameActive {
            isBonusGameActive = true
            showPrizImage = true // Show the "priz" image
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showPrizImage = false // Hide the "priz" image after 2 seconds
                let bonusScene = BonusGameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                bonusScene.scaleMode = .resizeFill
                bonusScene.scoreUpdateHandler = { score in
                    self.score = score
                }
                bonusScene.gameOverHandler = {
                    self.isBonusGameActive = false
                }
                bonusGameScene = bonusScene
            }
        }
    }
    
    func restartGame() {
        gameOver = false
        score = 0
        gameScene?.resetGame()
    }
}

struct GameView: View {
    var scene: GameScene?
    
    var body: some View {
        if let scene = scene {
            
            TransparentSpriteView(scene: scene)
                .edgesIgnoringSafeArea(.all)
        } else {
            Color.clear.edgesIgnoringSafeArea(.all)
        }
    }
}

struct BonusGameView: View {
    var scene: BonusGameScene?
    
    var body: some View {
        if let scene = scene {
            TransparentSpriteView(scene: scene)
                .edgesIgnoringSafeArea(.all)
        } else {
            Color.clear.edgesIgnoringSafeArea(.all)
        }
    }
}


struct ScoreTemplate: View {
    @Binding var score: Int
    
    var body: some View {
        ZStack {
            Image("score")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 120)
                .overlay(
                    ZStack {
                        Text("\(score)")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(Font.system(size: 30))
                            .position(x: 90, y: 62)
                    }
                )
        }
    }
}


struct WinView: View {
    @AppStorage("coinscore") var coinscore: Int = 10
    @Binding var score: Int
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
                                .font(Font.system(size: 35))
                                .padding(.top, 80)
                        }
                    )
                    .onTapGesture {
                        coinscore += score
                        NavGuard.shared.currentScreen = .MENU
                    }
            }
        }
    }
}

#Preview {
    PlayPage()
}




struct TransparentSpriteView: UIViewRepresentable {
    var scene: SKScene

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.allowsTransparency = true // Включаем прозрачность
        view.backgroundColor = .clear // Прозрачный фон
        view.isOpaque = false
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.presentScene(scene)
    }
}
