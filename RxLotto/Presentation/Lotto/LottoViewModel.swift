//
//  LottoViewModel.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import Foundation

import RxSwift
import RxCocoa

final class LottoViewModel {
    private let firstLottoDate = Date(timeIntervalSinceReferenceDate: 86400 * 706)
    private let now = Date.now
    
    private(set) var numArray: [String] {
        get {
            let recent = Int(now.timeIntervalSince(firstLottoDate) / 86400 / 7) + 1
            let arr: [String] = Array(1...recent).map { String($0) }.reversed()
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
        let lottoResult: Driver<Lotto?>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let selectedRound = PublishRelay<String>()
        let lottoResult = PublishRelay<Lotto?>()
        
        // MARK: Using Map Operator
//        input.pickerSelected
//            .map { row, component in
//                return row
//            }
//            .map { self.numArray[$0] }
//            .bind(with: self, onNext: { owner, value in
//                print(value)
//                selectedRound.accept(value)
//                NetworkService.shared.callLottoAPI(round: value)
//                    .bind(with: self) { owner, result in
//                        lottoResult.accept(result)
//                        print(result)
//                    }
//                    .disposed(by: owner.disposeBag)
//            })
//            .disposed(by: disposeBag)
        
        
        // MARK: Using FlatMap Opertor
        input.pickerSelected
            .map { row, component in
                return row
            }
            .map { self.numArray[$0] }
            .flatMap {
                NetworkService.shared.callLottoAPI(round: $0)
                    .debug("API")
            }
        
            .bind(with: self, onNext: { owner, value in
                lottoResult.accept(value)
                print(value)
            })
            .disposed(by: disposeBag)

//            .subscribe(with: self, onNext: { owner, response in
//                print(#function, "onNext")
//            }, onError: { owner, error in
//                print(#function, "onError")
//            }, onCompleted: { owner in
//                print(#function, "onCompleted")
//            }, onDisposed: { owner in
//                print(#function, "onDisposed")
//            })
        
        return Output(
            selectedRound: selectedRound.asDriver(onErrorJustReturn: ""),
            lottoResult: lottoResult.asDriver(onErrorJustReturn: nil)
        )
    }
}
