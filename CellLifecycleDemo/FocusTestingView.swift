import SwiftUI

struct FocusTestingView: View {

  @Namespace var mainNamespace
  @Namespace var nameSpaceL
  @Namespace var nameSpaceR
  @Environment(\.resetFocus) var resetFocus
  @State var selectedButtonTitleL: String?
  @State var selectedButtonTitleR: String?
  @FocusState var isFocusedL
  @FocusState var isFocusedR
  @FocusState var isFocusedTabBar

  var body: some View {
    HStack {
      VStack {
        Spacer()
        FocusButton(title: "1", selectedButtonTitle: $selectedButtonTitleL)
//          .prefersDefaultFocus(false, in: nameSpaceL)
        FocusButton(title: "2", selectedButtonTitle: $selectedButtonTitleL)
          .prefersDefaultFocus(in: nameSpaceL)
//          .prefersDefaultFocus(false, in: nameSpaceL)
        FocusButton(title: "3", selectedButtonTitle: $selectedButtonTitleL)
        FocusButton(title: "4", selectedButtonTitle: $selectedButtonTitleL)
        FocusButton(title: "5", selectedButtonTitle: $selectedButtonTitleL)
        Spacer()
      }
      .focusSection()
      .focusScope(nameSpaceL)
      .focused($isFocusedL)
//      .focusable { isFocused in
//        if isFocused {
//          resetFocus(in: mainNamespace)
//        }
//      }
      .onExitCommand(perform: {
        resetFocus(in: nameSpaceL)
      })

      VStack {
        Spacer()
        FocusButton(title: "A", selectedButtonTitle: $selectedButtonTitleR)
//          .focusable(false)
        FocusButton(title: "B", selectedButtonTitle: $selectedButtonTitleR)
          .prefersDefaultFocus(in: nameSpaceR)
        FocusButton(title: "C", selectedButtonTitle: $selectedButtonTitleR)
//          .prefersDefaultFocus(in: nameSpaceR)
        FocusButton(title: "D", selectedButtonTitle: $selectedButtonTitleR)
//          .prefersDefaultFocus("D" == selectedButtonTitleL, in: nameSpaceR)
        FocusButton(title: "E", selectedButtonTitle: $selectedButtonTitleR)
//          .prefersDefaultFocus("E" == selectedButtonTitleL, in: nameSpaceR)
//          .focusable { isFocused in
//            if isFocused {
//              resetFocus(in: subNamespace)
//            }
//          }
        Spacer()
      }
      .focusSection()
      .focusScope(nameSpaceR)
      .focused($isFocusedR)
      .onExitCommand(perform: {
        isFocusedL = true
        Task {
          try? await Task.sleep(nanoseconds: 1)
          resetFocus(in: nameSpaceL)
        }

//        resetFocus(in: mainNamespace)
      })
      .prefersDefaultFocus(in: mainNamespace)
    }
    .focusScope(mainNamespace)
//    .onExitCommand(perform: {
//      isFocusedTabBar = true
//      resetFocus(in: mainNamespace)
//    })
    .frame(width: 500)
    .background(.brown)
//    .onChange(of: isFocusedL) { oldValue, newValue in
//      resetFocus(in: nameSpaceR)
//    }

    Button("Press menu here to exit") {}
  }

}

struct FocusButton: View {
  let title: String
  @Binding var selectedButtonTitle: String?

  var body: some View {
    Button (title) { selectedButtonTitle = title }
      .background(selectedButtonTitle == title ? .red : .clear)
  }
}
