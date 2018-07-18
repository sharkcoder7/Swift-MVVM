//
//  DogsViewModel.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import Foundation
import RxSwift

class DogsViewModel {
    let networkManager = NetworkManager.init(apiURL: "https://dog.ceo/api/")
    
    var dogsViewModels : Variable<[DogViewModel]> = Variable.init([])
    var dataUpdated : PublishSubject<Bool> = PublishSubject()
    
    var dogsCount : Int {
        return dogsViewModels.value.count
    }
    
    init() {
        loadDogs()
    }
    
    func loadDogs() {
        networkManager.getRandomDogs { (response, error) in
            guard let response = response, error == nil else {
                return
            }
            self.dataUpdated.onNext(true)
            self.dogsViewModels.value += response.message.map{DogViewModel.init(dog: Dog(imageUrl: $0))}
        }
    }
    
    func dogViewModel(for row : Int) -> DogViewModel  {
        return dogsViewModels.value[row]
    }
}
