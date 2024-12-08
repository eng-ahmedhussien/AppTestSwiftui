//
//  DropDownMenuListView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 10/11/2024.
//


import SwiftUI

struct AppDropDownMenuListView<T: SelectionExtendProtocol, Cell: View, Divider: View>: View {
    
    @State var isTapped: Bool =  false
    @Binding var data: DropDownData<T>
    let isShowDivider: Bool
    var isDisabled: Bool = false
    var placeholderText: String
    let divider: Divider
    let cellProvider: (T) -> Cell
    
    var body: some View {
        VStack{
                Label("Add a new payment method", image: "plus")
                    
                    .foregroundColor(.primary)
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .cardBackground(color: .white,
                                    cornerRadius: 30,
                                    shadowRadius: 2,
                                    shadowColor: .gray)
                    .padding()
            TitleDropDownView(selection: data.selection,
                              placeholderText: placeholderText,
                              isDisabled : isDisabled)
            .padding()
            .onTapGesture {
                isTapped.toggle()
            }
            .disabled(isDisabled)
            .overlay(alignment: .topLeading) {
                VStack{
                    Spacer(minLength: 50)
                    if isTapped {
                        DropDownExtendListView<T,Cell,Divider>(data: $data,
                                                               isShowDivider: isShowDivider,
                                                               cellProvider: cellProvider,
                                                               isTapped: $isTapped,
                                                               divider: divider)
                        .transition(.scale(scale: 0.8, anchor: .top).combined(with: .opacity).combined(with: .offset(y: -10)))
                        .frame(height: 200)
                        .padding(.top, 20)
                    }
                }
            }
            
        }
    }
}

private struct TestSelectionExtendModel: SelectionExtendProtocol {
    var id: String? = UUID().uuidString
    var name: String?
    var imageName: String?
    var subTitle: String?
    var amount: String?
}

private struct TestCell: View {
    let model: any SelectionExtendProtocol
    var body: some View {
        HStack{
            Image(model.imageName ?? "")
                .resizable()
                .frame(width: 60, height: 60)
            VStack{
                Text(model.name ?? "nill")
                Text(model.subTitle ?? "nill")
            }
            Spacer()
            Text(model.amount ?? "nill")
        }
    }
}

private struct TestDivider: View {
    var body: some View {
        Divider()
    }
}

#Preview {
    AppDropDownMenuListView<TestSelectionExtendModel,
                            TestCell,
                            TestDivider>(isTapped: false,
                                         data: .constant(DropDownData(dataArray: [
                                            TestSelectionExtendModel( name: "image 2", imageName: "tamara-logo-badge-en", subTitle: "sub title", amount: "20"),
                                            TestSelectionExtendModel( name: "image 2", imageName: "tamara-logo-badge-en", subTitle: "sub title", amount: "20"),
                                            TestSelectionExtendModel( name: "image 2", imageName: "tamara-logo-badge-en", subTitle: "sub title", amount: "20"),
                                            TestSelectionExtendModel( name: "image 2", imageName: "tamara-logo-badge-en", subTitle: "sub title", amount: "20")
                                         ])),
                                         isShowDivider: true,
                                         isDisabled: false,
                                         placeholderText: "Select an option",
                                         divider: TestDivider(),
                                         cellProvider: { item in TestCell(model: item) })
}

protocol SelectionExtendProtocol:  IdentifiableHashableCodable, SelectionProtocol {
    var subTitle: String? { get }
    var amount: String? { get }
}



struct DropDownExtendListView<T: SelectionExtendProtocol, Cell: View, Divider: View>: View {
    
    @State private var scrollViewContentHeight: Double = 0.0
    
    @Binding var data: DropDownData<T>
    let isShowDivider: Bool
    let cellProvider: (T) -> Cell
    
    let scrollViewHeight = 300.0
    
    @Binding var isTapped: Bool

    let divider: Divider

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(data.dataArray, id: \.id) { item in
                    cellProvider(item)
                        .padding(12)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard let id = item.id else {return}
                            data.selectItem(id: id)
                            isTapped = false
                        }
                    if isShowDivider && item.id != data.dataArray.last?.id  {
                        divider
                    }
                }
            }
            .padding(.top, 30)
//            .background(
//                GeometryReader { geo -> Color in
//                    DispatchQueue.main.async {
//                        scrollViewContentHeight = geo.size.height
//                    }
//                    return Color.clear
//                }
//            )
        }
        .background(.clear)
//        .frame(maxHeight: scrollViewContentHeight > scrollViewHeight ? scrollViewHeight : scrollViewContentHeight)
        
    }
}

struct TitleDropDownView<T: SelectionProtocol>: View {
    
    var selection: T?
    let placeholderText: String
    var isDisabled: Bool = false
    
    var body: some View {
        HStack{
            Text(selection == nil ? placeholderText : selection?.name ?? "")
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal)
                .foregroundColor(isDisabled ? .gray : .white)
            Spacer()
            Image(systemName: "arrowshape.down.circle.fill")
                .padding(4)
        
        }
        .padding(10)
        .background(isDisabled ? .gray : .blue)
        .cornerRadius(25)
        
    }
}
