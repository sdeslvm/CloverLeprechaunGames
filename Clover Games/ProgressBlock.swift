import SwiftUI

struct ProgressBlock: View {
    var imagePath: String // Картинка для фона блока
    @Binding var progressText: String
    var level: String // Текст уровня

    var body: some View {
        HStack {
            Image(imagePath)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 100)
                .overlay(
                    ZStack {
                        Text(progressText)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 10) // Для текста добавим тень для читаемости
                        
                        Text(level)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 10) // Для текста добавим тень для читаемости
                            .position(x: 410, y: 50)
                    }
                )
            
            
            
        }

    }
}



