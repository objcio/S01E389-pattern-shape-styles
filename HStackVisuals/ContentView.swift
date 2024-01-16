//

import SwiftUI

struct HLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DiagonalPattern: View {
    var body: some View {

        GeometryReader { proxy in
            let line = HLine()
                .frame(width: proxy.size.width*2)
                .rotationEffect(.degrees(-45))

            let o = proxy.size.width/2
            ZStack {
                line
                    .offset(x: -o, y: -o)
                line
                line
                    .offset(x: o, y: o)
            }
        }
    }
}

extension Image {
    @MainActor static func striped(size: CGFloat, scale: CGFloat) -> Image {
        let content = DiagonalPattern()
            .foregroundColor(.primary)
            .frame(width: size, height: size)
        let renderer =  ImageRenderer(content: content
        )
        renderer.scale = scale
        return Image(renderer.cgImage!, scale: scale, label: Text(""))
    }
}

struct DiagonalStripes: ShapeStyle {
    var size: CGFloat = 30

    @MainActor func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        .image(Image.striped(size: size, scale: environment.displayScale))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RoundedRectangle(cornerRadius: 25)
        .fill(DiagonalStripes())
        .frame(width: 100, height: 100)
        .padding(50)
}
