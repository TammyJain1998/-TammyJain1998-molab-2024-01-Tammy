import SwiftUI

struct SingleSlideView: View {
    var song: Song
    @Binding var slideIndex: Int
    
    var body: some View {
        VStack {
            Image(song.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .cornerRadius(20)
            Text(song.singerName)
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
    }
}
