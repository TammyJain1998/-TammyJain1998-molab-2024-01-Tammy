//import SwiftUI
//
//struct CompactView: View {
//    var items: [MyListItem]
//
//    var body: some View {
//        HStack {
//            ForEach(items.prefix(2)) { item in
//                VStack {
//                    Image(item.imageName)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 150, height: 150)
//                        .cornerRadius(5)
//
//                    Text(item.name)
//                        .font(.headline)
//                        .padding(.top, 8)
//                }
//                .padding(.vertical, 10)
//                .padding(.horizontal, 10)
//            }
//        }
//    }
//}
//
//struct MyListItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let imageName: String
//}
//
//struct CompactView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompactView(items: [
//            MyListItem(name: "Item 1", imageName: "Image"),
//            MyListItem(name: "Item 2", imageName: "Image"),
//            MyListItem(name: "Item 3", imageName: "Image")
//        ])
//    }
//}
