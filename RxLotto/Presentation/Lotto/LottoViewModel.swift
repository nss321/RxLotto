//
//  LottoViewModel.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import RxSwift
import RxCocoa

final class LottoViewModel {
    private(set) var numArray: [String] {
        get {
            let arr: [String] = Array(1...1154).map { String($0) }.reversed()
            return arr
        }
        set {
            newValue
        }
    }
    struct Input {
        let pickerSelected: ControlEvent<(row: Int, component: Int)>
    }
    
    struct Output {
        let selectedRound: Driver<String>
    }
    
    private let disposeBag = DisposeBag()
    
    
    func transform(input: Input) -> Output {
        let selectedRound = PublishSubject<String>()
        
        input.pickerSelected
            .bind(with: self, onNext: { owner, value in
                selectedRound.onNext(owner.numArray[value.row])
            })
            .disposed(by: disposeBag)
        
        return Output(
            selectedRound: selectedRound.asDriver(onErrorJustReturn: "")
        )
    }
}
