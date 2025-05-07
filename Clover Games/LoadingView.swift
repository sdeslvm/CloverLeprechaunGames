import SwiftUI

struct LoadingScreen: View {

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ZStack {
                    Image(.backgroundLoading)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(1.3)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
