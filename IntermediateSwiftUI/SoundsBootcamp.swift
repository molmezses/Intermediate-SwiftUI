//
//  SoundsBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 15.02.2025.
//

import SwiftUI
import AVKit


class SoundsManager {
    
    static let instance = SoundsManager()
    
    var player: AVAudioPlayer?
    
    enum Sounds : String{
        case tada = "tada"
        case badum = "badum"
    }
    
    func playSounds(sounds: Sounds){
        //rawValue demek sounds nesneinden bir item gelecek demek 
        guard let url = Bundle.main.url(forResource: sounds.rawValue, withExtension: ".mp3") else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch{
            print("Error playing song \(error.localizedDescription)")
        }
    }
    
    
}

struct SoundsBootcamp: View {
    var body: some View {
        VStack(spacing:40){
            Button("Play sound #1") {
                SoundsManager.instance.playSounds(sounds: .badum)
            }
            Button("Play sound #2") {
                SoundsManager.instance.playSounds(sounds: .tada)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
