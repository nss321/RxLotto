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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkService.shared.callLottoAPI(round: viewModel.numArray.first ?? "")
            .observe(on: MainScheduler.instance)
//            .subscribe(on: <#T##any ImmediateSchedulerType#>)
            .bind(with: self) { owner, response in
                owner.lottoView.configView(lotto: response)
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        let pickerTitles = Observable.just(viewModel.numArray)
        
        let input = LottoViewModel.Input(
            pickerSelected: lottoView.pickerView.rx.itemSelected,
            observableButtonTap: lottoView.observableButton.rx.tap,
            singleButtonTap: lottoView.singleButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.selectedRound
            .drive(
                lottoView.textField.rx.text
            )
            .disposed(by: disposeBag)
        
        output.lottoResult
            .drive(with: self) { owner, response in
                if let response {
                    owner.lottoView.configView(lotto: response)
                }
            }
            .disposed(by: disposeBag)
        
        pickerTitles
            .bind(to: lottoView.pickerView.rx.itemTitles)  { row, component in
                return "\(component)"
            }
            .disposed(by: disposeBag)
        
//        lottoView.pickerView.rx.itemSelected
//            .bind(with: self) { owner, _ in
//                owner.lottoView.textField.resignFirstResponder()
//            }
//            .disposed(by: disposeBag)
    }
}

