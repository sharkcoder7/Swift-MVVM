//
//  DogViewModel.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import Foundation

class DogViewModel {
    fileprivate let dog : Dog
    
    init(dog : Dog) {
        self.dog = dog
    }
    
    var dogImageURL : URL? {
        return URL.init(string: dog.imageUrl)
    }
}
