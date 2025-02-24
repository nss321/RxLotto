//
//  ViewController.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import UIKit

import RxSwift
import RxCocoa

final class LottoViewController: UIViewController {
    
    private let lottoView = LottoView()
    private let viewModel = LottoViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = lottoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
//        print(viewModel.firstLottoDate)
//        print(Int(Date.now.timeIntervalSince(viewModel.firstLottoDate) / 86400 / 7) + 1)
//        print(Date.now.timeIntervalSince(viewModel.firstLottoDate) / 86400 / 7)
//        print(Date.now.addingTimeInterval(86400 * 5).timeIntervalSince(Date.now) / 86400 / 7)
    }
    
    private func bind() {
        let pickerTitles = Observable.just(viewModel.numArray)
        
        let input = LottoViewModel.Input(
            pickerSelected: lottoView.pickerView.rx.itemSelected
        )
        
        let output = viewModel.transform(input: input)
        
        
        output.selectedRound
            .drive(
                lottoView.textField.rx.text
            )
            .disposed(by: disposeBag)
        
        output.lottoResult
            .drive(with: self, onNext: { owner, response in
                if let response {
                    owner.lottoView.configView(lotto: response)
                }
            },onCompleted: { owner in
                print(#function, "onCompleted")
            }, onDisposed: { owner in
                print(#function, "onDisposed")
            })
            .disposed(by: disposeBag)
        
        pickerTitles
            .bind(to: lottoView.pickerView.rx.itemTitles)  { row, component in
                return "\(component)"
            }
            .disposed(by: disposeBag)
        
        lottoView.pickerView.rx.itemSelected
            .bind(with: self) { owner, _ in
                owner.lottoView.textField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
    }
}

