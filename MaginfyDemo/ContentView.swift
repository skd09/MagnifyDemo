//
//  ContentView.swift
//  MaginfyDemo
//
//  Created by Sharvari on 2024-01-17.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScale = 1.0
    @GestureState private var magnifyBy = 1.0
    @State private var unit: UnitPoint = UnitPoint(x: 0.0, y: 0.0)

    var body: some View {
        VStack {
            Image("Image")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .scaleEffect(currentScale, anchor: unit)
                .gesture(magnification)

            Text("Hello, world!")
        }
        .padding()
    }

    var magnification: some Gesture {
        if #available(iOS 17.0, *) {
            return MagnifyGesture()
                .updating($magnifyBy) { value, gestureState, transaction in
                    gestureState = value.magnification
                }
                .onChanged { value in
                    withAnimation(.spring) {
                        currentScale = min(max(value.magnification, 1.0), 3.0)
                        unit = value.startAnchor
                    }
                }
        } else {
            return MagnificationGesture()
                .updating($magnifyBy) { value, scale, transaction in
                    scale = value
                }
                .onChanged { value in
                    withAnimation(.spring) {
                        currentScale = min(max(value, 1.0), 3.0)
                        unit = .center
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
