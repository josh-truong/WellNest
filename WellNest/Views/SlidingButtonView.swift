import SwiftUI

struct SlidingButtonView: View {
    @Binding var toggle: Bool
    @State private var lToggle: Bool = true
    @State private var rToggle: Bool = false
    var lhs: String
    var rhs: String

    var body: some View {
        GeometryReader { geometry in
            let width = max(lhs.width(font: .body), rhs.width(font: .body)) + 50

            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray)
                    .frame(height: 50)

                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .frame(width: width + 20, height: 45) // Use the maximum width with some padding
                    .offset(x: toggle ? (width + 20) / 2 : -(width + 20) / 2)

                HStack {
                    Text(lhs) // Use leftButtonText for the left button
                        .offset(x: -(width + 20) / 4) // Adjust the offsets based on the button size
                        .onTapGesture {
                            withAnimation {
                                if !lToggle {
                                    lToggle = true
                                    rToggle = false
                                    toggle.toggle()
                                }
                            }
                        }

                    Text(rhs) // Use rightButtonText for the right button
                        .offset(x: (width + 20) / 4) // Adjust the offsets based on the button size
                        .onTapGesture {
                            withAnimation {
                                if !rToggle {
                                    lToggle = false
                                    rToggle = true
                                    toggle.toggle()
                                }
                            }
                        }
                }
            }
        }
        .frame(height: 50)
    }
}

extension String {
    func width(font: Font) -> CGFloat {
        let size = self.size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .body)])
        return size.width
    }
}

struct SlidingButtonView_ContentPreviews: View {
    @State private var isToggled = false

    var body: some View {
        VStack {
            SlidingButtonView(toggle: $isToggled, lhs: "Profile", rhs: "Settings")
        }
    }
}

struct SlidingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingButtonView_ContentPreviews()
    }
}
