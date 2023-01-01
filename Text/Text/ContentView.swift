//
//  ContentView.swift
//  Text
//
//  Created by Elaidzha Shchukin on 31.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Apple()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Apple: View {

    @State var multiColor = false
    var body: some View {
        
        VStack(spacing: 25) {
            
            TextShimmer(text: "Happy New Year !!!", multiColors: $multiColor)
            TextShimmer(text: "С Новым Годом !!!", multiColors: $multiColor)
            TextShimmer(text: "Sawade pee Mai !!!", multiColors: $multiColor)
            
            Toggle(isOn: $multiColor, label: {
                Text("Enable Multi Color")
                    .font(.title)
                    .fontWeight(.bold)
                
            })
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View {
        
        ZStack {
            
            Text(text)
                .font(.system(size: 40, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.25))
            
            HStack(spacing: 0) {
                
                ForEach(0..<text.count,id: \.self) {index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 40, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            .mask (
                
                Rectangle()
                    .fill(
                    
                        LinearGradient(gradient: .init(colors: [Color.black.opacity(0.5), Color.white, Color.white]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                 //   .padding()
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    animation.toggle()
                }
            })
        }
    }
    
    func randomColor()->Color {
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}
