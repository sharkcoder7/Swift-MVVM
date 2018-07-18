//
//  ViewController.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import UIScrollView_InfiniteScroll

class DogsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = DogsViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
        setupUI()
    }
    
    func setupUI() {
        tableView.addInfiniteScroll { [weak self] (tableView) in
            self?.viewModel.loadDogs()
        }
    }
    
    func setupObservables() {
        viewModel.dataUpdated.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (_) in
            self?.tableView.finishInfiniteScroll(completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.dogsViewModels.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "SingleDogTableViewCell",
                                         cellType: SingleDogTableViewCell.self)) { [weak self] (row, element, cell) in
                                            guard let `self` = self, let imageURL = element.dogImageURL else {return}
                                            self.set(imageURL: imageURL, of: cell)
            }
            .disposed(by: disposeBag)
    }

    func set(imageURL : URL, of cell : SingleDogTableViewCell) {
        cell.dogImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { [weak cell] (image, error, cacheType, url) in
            guard error == nil else {return}
            guard cacheType == .none else {
                cell?.dogImageView.isHidden = false
                return
            }
            cell?.dogImageView.alpha = 0.0
            cell?.dogImageView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                cell?.dogImageView.alpha = 1.0
            })
        })
    }
}

extension DogsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}

