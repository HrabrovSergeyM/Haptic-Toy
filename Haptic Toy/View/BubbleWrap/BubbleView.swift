import SwiftUI

struct BubbleView: View {
    var body: some View {
        ZStack {
//            Color("BubbleWrapBackground").ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            VStack {
                ForEach(0..<10) { index in
                    if index % 2 > 0 {
                        HStack {
                            ForEach(0..<5) { _ in
                                Bubble()
                            }
                        }
                    } else {
                        HStack {
                            ForEach(0..<4) { _ in
                                Bubble()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct Bubble: View {
    @State var isPopped: Bool = false
    
    var prepopped: [String] = ["softPrepopped", "softPrepopped2", "softPrepopped3", "softPrepopped4"]

    var body: some View {
        Image((isPopped ? "popped" : prepopped.randomElement())!)
            .resizable()
            .scaledToFit()
            .onTapGesture {
                withAnimation(.default) {
                    isPopped = true
                }
            }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView()
    }
}
