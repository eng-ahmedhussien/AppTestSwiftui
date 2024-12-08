//
//  CustomPickerView.swift
//  AppTest
//
//  Created by ahmed hussien on 14/03/2024.
//



import SwiftUI
import MijickNavigattie

struct ContentView2: NavigatableView {
    
    struct TestSelectionModel: SelectionProtocol {
        var id: String?
        var name: String?
    }
    
    @State  var normalDropDownData = DropDownData(dataArray: [
        TestSelectionModel(id: "1", name: "One"),
        TestSelectionModel(id: "4", name: "Four"),
        TestSelectionModel(id: "4", name: "Four"),
        TestSelectionModel(id: "4", name: "Four"),
        TestSelectionModel(id: "4", name: "Four"),
        TestSelectionModel(id: "4", name: "Four"),
        TestSelectionModel(id: "4", name: "Four")
    ])
   
    @State var se  = ""
    
    var body: some View {
        DropDwonList(data: $normalDropDownData, style: .default, selectionClouser: { selection in
            // selection
            let  _ = print("\(normalDropDownData.selection?.name ?? "nill ")")
        })
    }
}

#Preview {
    ContentView2()
        .preferredColorScheme(.light)
        .frame(width: 280, height: 350)
        .padding()
}



struct DropDwonList<T: SelectionProtocol>: View  {
    
    @State var isPicking = false
    @Binding var data: DropDownData<T>
    var selectionClouser: (T) -> Void
    let style: DropDownStyle
    
    //Getter Attributes
    private var styleConfig: DropDwonListStyleConfig {
        get {
            style.styleConfig
        }
    }
    private var dataCount : Int{
        data.dataArray.count
    }
    
    init(data: Binding<DropDownData<T>>, style: DropDownStyle = .default, selectionClouser: @escaping (T) -> Void) {
        self._data = data
        self.style = style
        self.selectionClouser = selectionClouser
    }
        
    var body: some View {
        HStack {
            Text(data.selection?.name ?? "Select")
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .foregroundColor(styleConfig.buttonTextColor)
            Spacer()
            Image(systemName: isPicking ? "chevron.up" : "chevron.down")
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: styleConfig.buttonHeight)
        .background(
            RoundedRectangle(cornerRadius: styleConfig.buttonCornerRadius)
                .fill(styleConfig.buttonBackgroundColor)
                .stroke(styleConfig.buttonStrokeColor, lineWidth: 1)
        )
        .onTapGesture {
            isPicking.toggle()
        }
        // Picker
        .overlay(alignment: .topLeading) {
            VStack {
                if isPicking {
                    Spacer(minLength: styleConfig.buttonHeight)
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(data.dataArray, id: \.self) { item in
                                //Divider()
                                Button {
                                    data.selection = item
                                    selectionClouser(item)
                                    isPicking.toggle()
                                } label: {
                                    Text(item.name ?? "test")
                                        .foregroundColor(styleConfig.listItemTextColor)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                        .frame(height: styleConfig.buttonHeight)
                                        .frame(maxWidth: .infinity, alignment: styleConfig.listItemTextAlingment)
                                        .background {
                                            RoundedRectangle(cornerRadius: styleConfig.buttonCornerRadius)
                                                .fill(styleConfig.listItemBackgroundColor)
                                        }
                                     
                                }
                                .buttonStyle(.plain)
                                Divider()
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .scrollIndicators(.never)
                    .frame(minHeight: dataCount < 4 ? styleConfig.buttonHeight * CGFloat(dataCount) : styleConfig.listHeight   )
                    .background(styleConfig.listBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: styleConfig.buttonCornerRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: styleConfig.buttonCornerRadius)
                            .stroke(styleConfig.buttonStrokeColor, lineWidth: 0.6)
                    )
                    .transition(.scale(scale: 0.8, anchor: .top).combined(with: .opacity).combined(with: .offset(y: -10)))
                }
            }
        
        }
        .padding(.horizontal, 12)
        .font(.custom("RetroComputer", size: 13))
        .animation(.easeIn(duration: 0.12), value: isPicking)
        .zIndex(1)
    }
}




protocol IdentifiableHashableCodable: Identifiable, Hashable, Codable {}
protocol SelectionProtocol:  IdentifiableHashableCodable {
    var id: String? { get }
    var name: String? { get }
    var imageType: DropDownImageType? { get }
    var imageName: String? { get }
}
extension SelectionProtocol {
    var imageType: DropDownImageType? {
        get {
            return nil
        }
    }
    
    var imageName: String? {
        get {
            return nil
        }
    }
}
enum DropDownImageType {
    case systemImage
    case assetImage
}
struct DropDownData<T: SelectionProtocol> {
    var dataArray: [T]
    var selection: T?
    var isValid: Bool = false
    
    mutating func selectItem(id: String) {
        guard let selectedItem = dataArray.first(where: { $0.id == id }) else { return }
        self.selection = selectedItem
    }
    
    mutating func changeDataArray(dataArray: [T]) {
        self.dataArray = dataArray
    }
}

enum DropDownStyle {
    case `default`
    case custom(config: DropDwonListStyleConfig)
}
extension DropDownStyle {
    var styleConfig: DropDwonListStyleConfig {
        switch self {
        case .default:
            return DropDwonListStyleConfig(
                buttonBackgroundColor: .white,
                buttonStrokeColor: .black,
                buttonTextColor: .black,
                buttonCornerRadius: 25,
                buttonHeight: 40,
                
                listItemBackgroundColor: .white,
                listItemHoverColor: .gray.opacity(0.5),
                listItemTextColor: .black,
                listBackgroundColor: .white,
                listHeight: 200,
                listItemTextAlingment: .center
                
            )
        case .custom(let config):
            return config
        }
    }
}
struct DropDwonListStyleConfig {
    
    let buttonBackgroundColor: Color
    let buttonStrokeColor: Color
    let buttonTextColor: Color
    let buttonCornerRadius: CGFloat
    let buttonHeight: CGFloat
    //list
    let listItemBackgroundColor: Color
    let listItemHoverColor: Color
    let listItemTextColor: Color
    let listBackgroundColor: Color
    let listHeight: CGFloat
    let listItemTextAlingment : Alignment
    
}

// MARK: - Alignments
extension View {
    func alignVertically(_ edge: VerticalAlignment, _ value: CGFloat = 0) -> some View {
        VStack(spacing: 0) {
            Spacer.height(edge == .top ? value : nil)
            self
            Spacer.height(edge == .bottom ? value : nil)
        }
    }
    func alignHorizontally(_ alignment: HorizontalAlignment, _ value: CGFloat = 0) -> some View {
        HStack(spacing: 0) {
            Spacer.width(alignment == .leading ? value : nil)
            self
            Spacer.width(alignment == .trailing ? value : nil)
        }
    }
}

extension Spacer {
    @ViewBuilder static func width(_ value: CGFloat?) -> some View {
        switch value {
            case .some(let value): Spacer().frame(width: max(value, 0))
            case nil: Spacer()
        }
    }
    @ViewBuilder static func height(_ value: CGFloat?) -> some View {
        switch value {
            case .some(let value): Spacer().frame(height: max(value, 0))
            case nil: Spacer()
        }
    }
}

// MARK: - Numeric Helpers
extension CGFloat {
    static var margin: CGFloat { UIScreen.margin }
}
extension UIScreen {
    static let width: CGFloat = UIScreen.main.bounds.size.width
    static let safeArea: UIEdgeInsets = {
        UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow})
            .first?
            .safeAreaInsets ?? .zero
    }()
    static let margin: CGFloat = 28
}



