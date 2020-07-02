//
//  ContentView.swift
//  SwiftUI-BounceAnimation
//
//  Created by Ben Scheirman on 7/1/20.
//

import SwiftUI

struct BounceEffect: GeometryEffect {
    var height: CGFloat
    var times: CGFloat
    
    init(height: CGFloat = 50, times: Int) {
        self.times = CGFloat(times)
        self.height = height
    }
    
    var animatableData: CGFloat {
        get { times }
        set { times = newValue }
    }
    
    private func bounceY(_ x: CGFloat) -> CGFloat {
        abs(sin(x * .pi))
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(.init(translationX: 0, y: -height * bounceY(times)))
    }
}

extension View {
    func bounce(_ n: Int) -> some View {
        modifier(BounceEffect(times: n))
    }
}

struct ContentView: View {
    
    @State var bounces: Int = 0
    
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .bounce(bounces)
                .animation(Animation.linear(duration: 2))
            
            Button(action: {
                bounces += 3
            }) {
                Text("Animate!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
