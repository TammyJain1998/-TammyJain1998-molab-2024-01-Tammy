import SwiftUI

struct Song_List: View {
    var songs: [Song] = []
    
    var body: some View {
        NavigationView {
            List(songs) { song in
                NavigationLink(destination: SlideShowView(song: song)) {
                    HStack {
                        Image(song.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(song.name)
                                .foregroundColor(Color.white)
                            Text(song.singerName)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("All Songs"))
        }
    }
}
struct Song_List_Previews: PreviewProvider {
    static var previews: some View {
        Song_List(songs: testdata)
    }
}
