import SwiftUI

struct BulletedListView: View {
    
    let items = [
        "First item with some long text to test wrapping",
        "Second item",
        "Third item"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("SwiftUI - AttributedString")
                    .font(.title)
                
                Text(createBulletedList(strings: items))
                
                Divider()
                
                Text("SwiftUI - Recommended Way (UI بناء)")
                    .font(.title)
                
                BulletListView(items: items)
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

#Preview {
    BulletedListView()
}
