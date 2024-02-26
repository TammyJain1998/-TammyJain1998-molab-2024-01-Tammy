//
//  List.swift
//  SaReGaMa Carvaan App
//
//  Created by Tamanna Jain on 2/25/24.
//

import SwiftUI

struct Song : Identifiable {
    var id = UUID()
    var name : String
    var singerName : String
    var imageName : String
    var audioFileName: String // Add audio file name property
}

let testdata = [
    Song(name : "Dekha Ek Khwaab", singerName : "Lata Mangeshkar & Kishore Kumar", imageName : "Dekha Ek Khwaab", audioFileName: "Dekha Ek Khwab Song  Silsila  Amitabh Bachchan, Rekha  Kishore Kumar, Lata Mangeshkar, Shiv-Hari.mp3"),
    Song(name : "Mere Saamne Wali Khidki Mein", singerName : "Kishore Kumar", imageName : "Mere Saamne Waali Khidki Mein", audioFileName: "Mere Samne Wali Khidki Mein - Padosan - Saira Banu, Sunil Dutt & Kishore Kumar - Old Hindi Songs.mp3"),
    Song(name : "Keh Dun Tumhe", singerName : "Aasha Bhosle & Kishore Kumar", imageName : "Keh Dun Tumhe", audioFileName: "कह द तमह य चप रह  Kehdoon Tumhe, Ya Chup Rahun  Kishore Kumar  Deewaar Romantic Song 4K.mp3")
]
