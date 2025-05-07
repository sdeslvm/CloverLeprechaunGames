
import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String
    var loopMode: LottieLoopMode = .loop
    var contentMode: UIView.ContentMode = .scaleAspectFill
    var playReverse: Bool = false

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        // Create and configure the animation view
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
        animationView.loopMode = loopMode
        
        animationView.contentMode = contentMode
        
        if playReverse {
               animationView.animationSpeed = -1 // Negative value plays the animation in reverse
           }
        
        animationView.play()

        // Add the animation view as a subview
        view.addSubview(animationView)

        // Set animationView to match the size of its parent view
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        // This function can be used to update the view with new data.
        // Currently, it does nothing.
    }
}
