import SwiftUI

struct ContentsView: View {
    // Example data structure
    let items: [MyListItem] = [
        MyListItem(name: "Item 1", imageName: "Image"),  // Make sure "Image" corresponds to an image in your assets
        MyListItem(name: "Item 2", imageName: "Image"),
        MyListItem(name: "Item 3", imageName: "Image")
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    VStack {
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .cornerRadius(5)

                        Text(item.name)
                            .font(.headline)  // Adjust font style as needed.
                            .padding(.top, 8)  // Adds space between the image and the text.
                    }
                    .padding(.vertical, 10)  // Adds space above and below each item.
                    .padding(.horizontal, 10)  // Adds horizontal space between items.
                }
            }
        }
    }
}

// Data model for the items in the list, renamed to avoid conflicts
struct MyListItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
    }
}
