import SwiftUI



struct MenuView: View {

    

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    HStack {
                        BalanceTemplate()
                        Spacer()
                        ButtonTemplateSmall(image: "settings", action: {NavGuard.shared.currentScreen = .SETTINGS})
                    }
                    Spacer()
                }
                
                HStack {
                    ButtonTemplateBig(image: "quiz", action: {NavGuard.shared.currentScreen = .QUIZ})
                    ButtonTemplateBig(image: "play", action: {NavGuard.shared.currentScreen = .GAME})
                }
                
                VStack {
                    Spacer()
                    HStack {
                        ButtonTemplateBig(image: "rules", action: {NavGuard.shared.currentScreen = .RULES})
                        Spacer()
                        ButtonTemplateBig(image: "rait", action: {NavGuard.shared.currentScreen = .STATS})
                    }
                }
                
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image(.backgroundMenu)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
           
        }
    }
}




struct BalanceTemplate: View {
    @AppStorage("coinscore") var coinscore: Int = 10
    
    var body: some View {
        ZStack {
            Image("money")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 120)
                .overlay(
                    ZStack {
                        Text("\(coinscore)")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .position(x: 100, y: 62)
                    }
                )
        }
    }
}





struct ButtonTemplateSmall: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

struct ButtonTemplateBig: View {
    var image: String
    var isEnabled: Bool = true
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .shadow(radius: 10)
                .opacity(isEnabled ? 1.0 : 0.5)
        }
        .onTapGesture {
            if isEnabled {
                withAnimation(.easeInOut(duration: 0.2)) {
                    action()
                }
            }
        }
    }
}



#Preview {
    MenuView()
}

