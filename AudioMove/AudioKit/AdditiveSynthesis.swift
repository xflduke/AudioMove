//
//  AdditiveSynthesis.swift
//  AudioMove
//
//  Created by duke on 2019/02/11.
//  Copyright © 2019 duke. All rights reserved.
//

import Foundation
import AudioKitUI
import AudioKit

func createAndStartOscillator(frequency: Double) -> AKOscillator {
    let oscillator = AKOscillator()
    oscillator.frequency = frequency
    oscillator.start()
    return oscillator
}
