//: ## High Shelf Filter
//:
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0])

let player = AKPlayer(audioFile: file)
player.isLooping = true
player.buffering = .always

var filter = AKHighShelfFilter(player)
filter.cutoffFrequency = 10_000 // Hz
filter.gain = 0 // dB

AudioKit.output = filter
try AudioKit.start()
player.play()

//: User Interface Set up
import AudioKitUI

class LiveView: AKLiveViewController {

    override func viewDidLoad() {
        addTitle("High Shelf Filter")

        addView(AKResourcesAudioFileLoaderView(player: player, filenames: playgroundAudioFiles))

        addView(AKButton(title: "Stop") { button in
            filter.isStarted ? filter.stop() : filter.play()
            button.title = filter.isStarted ? "Stop" : "Start"
        })

        addView(AKSlider(property: "Cutoff Frequency",
                         value: filter.cutoffFrequency,
                         range: 20 ... 22_050,
                         format: "%0.1f Hz"
        ) { sliderValue in
            filter.cutoffFrequency = sliderValue
        })

        addView(AKSlider(property: "Gain",
                         value: filter.gain,
                         range: -40 ... 40,
                         format: "%0.1f dB"
        ) { sliderValue in
            filter.gain = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = LiveView()
