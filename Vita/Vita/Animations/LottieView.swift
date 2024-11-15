//
//  LottieView.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 15.10.24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animation: LottieAnimation?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            animationView.stop()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}
