//
//  BasicDropdownMenu.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 05/05/2025.
//

import SwiftUI

struct BasicDropdownMenu: View {
  @State private var selectedOption: String = "Select an Option"

  var body: some View {
      Menu {
          Button("Option 1", action: { selectedOption = "Option 1" })
          Button("Option 2", action: { selectedOption = "Option 2" })
          Button("Option 3", action: { selectedOption = "Option 3" })
          Button("Option 1", action: { selectedOption = "Option 1" })
          Button("Option 2", action: { selectedOption = "Option 2" })
          Button("Option 3", action: { selectedOption = "Option 3" })
          Button("Option 1", action: { selectedOption = "Option 1" })
          Button("Option 2", action: { selectedOption = "Option 2" })
          Button("Option 3", action: { selectedOption = "Option 3" })
      } label: {
      Label(selectedOption, systemImage: "chevron.down")
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
  }
}

#Preview {
  BasicDropdownMenu()
}

struct AnimatedDropdownMenu: View {
  @Namespace private var animationNamespace
  @State private var isExpanded = false
  @State private var selectedOption = "Select Option"
  let options = ["Option 5", "Option 2", "Option 3","Option 1", "Option 2", "Option 3"]

  var body: some View {
    VStack {
      Button(action: {
       // withAnimation(.spring()) {
          isExpanded.toggle()
       // }
      }) {
        HStack {
          Text(selectedOption)
          Spacer()
          Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
       .matchedGeometryEffect(id: "dropdown", in: animationNamespace)
      }
        
        if isExpanded {
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    ForEach(options, id: \.self) { option in
                        
                        Button(action: {
                            selectedOption = option
                            isExpanded = false
                        }) {
                            Text(option)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.matchedGeometryEffect(id: "dropdown-\(option)", in: animationNamespace)
                    }
                }
            }
        }
    }
    .padding()
  }
}

#Preview {
    VStack{
        AnimatedDropdownMenu()
        Spacer()
    }
}


struct SearchableDropdownMenu: View {
  @State private var isExpanded = false
  @State private var selectedOption = "Select an Option"
  @State private var searchText = ""
  let options = ["Apple", "Banana", "Orange", "Mango", "Pineapple", "Grapes"]

  var filteredOptions: [String] {
    if searchText.isEmpty {
      return options
    } else {
      return options.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
  }

  var body: some View {
    VStack {
      Button(action: { isExpanded.toggle() }) {
        HStack {
          Text(selectedOption)
          Spacer()
          Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(8)
      }

      if isExpanded {
        VStack {
          TextField("Search...", text: $searchText)
            .padding()

          ForEach(filteredOptions, id: \.self) { option in
              Button {
                  selectedOption = option
                  isExpanded = false
              } label: {
                  Text(option)
                      .frame(maxWidth: .infinity,alignment: .leading)
                      .foregroundStyle(Color.black)
                      .padding()
              }
          }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
      }
    }
    .padding()
  }
}
#Preview {
    VStack{
        SearchableDropdownMenu()
        Spacer()
    }
}


struct DropdownMenuDisclosureGroup: View {
  @State private var isExpanded: Bool = false
  @Binding var selectedOption: String
  var options: [String] = []

  var body: some View {
    DisclosureGroup(selectedOption.isEmpty ? "Select an option" : selectedOption, isExpanded: $isExpanded) {
      VStack(alignment: .leading) {
        ForEach(options, id: \.self) { option in
          Button(action: {
            withAnimation {
              selectedOption = option
              isExpanded = false
            }
          }) {
            Text(option)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.vertical, 8)
          }
         // .buttonStyle(PlainButtonStyle(isDisabled: <#Bool#>))
        }
      }
    }
    .foregroundStyle(.black)
    .padding()
    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
    .padding(.horizontal)
  }
}
#Preview {
    DropdownMenuDisclosureGroup(selectedOption: .constant(" "))
}
