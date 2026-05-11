import SwiftUI

struct BulletedListView: View {
    
    let items = [
        "First item with some long text to test wrapping",
        "Second item",
        "Third item"
    ]
    
    let itemsarabic = [
        "العنصر الأول: نص طويل لاختبار التفاف النص،",
        "العنصر الثاني",
        "العنصر الثالث"
    ]
    
    @Environment(\.layoutDirection) var layoutDirection
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("SwiftUI - AttributedString")
                    .font(.title)
                Text(createBulletedList(strings: itemsarabic))
                
                Divider()
                
                Text("SwiftUI - BulletListView - eng")
                    .font(.title)
                
                BulletListView(items: items)
                   
                
                Text("SwiftUI - BulletListView - arabic")
                    .font(.title)
                
                BulletListView(items: itemsarabic)
                   
                
//
//                Text("uikit - AttributedString")
//                    .font(.title)
//                
//                Text(createBulletedList(strings: items))
//                
//                Divider()
//                
//                Text(AttributedString(createUIKitBullets(strings: items)))
                
                Text("SwiftUI - BulletListView2 -eng")
                    .font(.title)
                BulletListView2(
                    items: items,
                    bulletFont: .system(size: 20, weight: .bold),
                    textFont: .system(size: 16),
                    textColor: .black
                )
                
                Text("SwiftUI - BulletListView2 - arabic")
                    .font(.title)
                
                BulletListView2(
                    items: itemsarabic,
                    bulletFont: .system(size: 20, weight: .bold),
                    textFont: .system(size: 16),
                    textColor: .black
                )
                
            }
            .padding()
        }
    }
    
    func createBulletedList(strings: [String]) -> AttributedString {
        
        var fullText = AttributedString()
        
        for (index, item) in strings.enumerated() {
            
            var bullet = AttributedString("• ")
            bullet.font = .system(size: 22, weight: .bold)
            bullet.baselineOffset = -3
            
            var text = AttributedString(item)
            text.font = .system(size: 16)
            
            var line = bullet + text
            
            if index < strings.count - 1 {
                line += AttributedString("\n")
            }
            
            fullText += line
        }
        
        return fullText
    }
    
    func createUIKitBullets(strings: [String]) -> NSAttributedString {
        
        let fullText = NSMutableAttributedString()
        
        for (index, item) in strings.enumerated() {
            
            let bullet = "• "
            var line = bullet + item
            
            if index < strings.count - 1 {
                line += "\n"
            }
            
            let attributed = NSMutableAttributedString(string: line)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.headIndent = 20
            paragraphStyle.lineSpacing = 6
            
            attributed.addAttributes([
                .font: UIFont.systemFont(ofSize: 16),
                .paragraphStyle: paragraphStyle
            ], range: NSRange(location: 0, length: attributed.length))
            
            attributed.addAttributes([
                .font: UIFont.boldSystemFont(ofSize: 22),
                .baselineOffset: -3
            ], range: NSRange(location: 0, length: 1))
            
            fullText.append(attributed)
        }
        
        return fullText
    }
}

struct BulletListView: View {
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: 8) {
                    
                    Text("•")
                        .font(.system(size: 22, weight: .bold))
                        .baselineOffset(-3)
                    
                    Text(item)
                        .font(.system(size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct BulletListView2: View {
    
    let items: [String]
    
    // MARK: - Customization
    var bullet: String = "•"
    var bulletFont: Font = .system(size: 18, weight: .bold)
    var bulletColor: Color = .primary
    
    var textFont: Font = .system(size: 16)
    var textColor: Color = .primary
    
    var spacing: CGFloat = 8
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: 8) {
                        bulletView
                        textView(item)
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var bulletView: some View {
        Text(bullet)
            .font(bulletFont)
            .foregroundColor(bulletColor)
    }
    
    private func textView(_ text: String) -> some View {
        Text(text)
            .font(textFont)
            .foregroundColor(textColor)
            .fixedSize(horizontal: false, vertical: true)
    }
}


#Preview {
    BulletedListView()
        .environment(\.layoutDirection, .rightToLeft)
}
