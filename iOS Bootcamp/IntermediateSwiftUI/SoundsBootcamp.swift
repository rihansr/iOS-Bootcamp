//
//  SoundsBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 25/10/2023.
//

import SwiftUI
import AVKit

final class SoundManager{
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func play(){
        // guard let url = URL(string: "") else { return }
        guard let url = Bundle.main.url(forResource: "tada", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct SoundsBootcamp: View {
    var body: some View {
        VStack{
            Button("PLAY"){ SoundManager.instance.play() }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
