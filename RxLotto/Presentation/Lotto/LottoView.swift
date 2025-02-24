//
//  LottoView.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import UIKit

import SnapKit

final class LottoView: UIView {
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.placeholder = "회차를 선택해주세요."
        view.borderStyle = .roundedRect
        view.inputView = pickerView
        return view
    }()
    
    private let notiLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2025-02-22"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    private let roundOfLottoLabel: UILabel = {
        let label = UILabel()
        label.text = "0000 당첨결과"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    let pickerView = UIPickerView()
    
    private let stackView = UIStackView()
    private let bnusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LottoView {
    private func configLayout() {
        [textField, notiLabel, dateLabel, dividerView, roundOfLottoLabel].forEach { addSubview($0) }
//        [firstNo, secondNo, thirdNo, fourthNo, fifthNo, sixthNo, plusLabel, bnusNo].forEach { stackView.addArrangedSubview($0) }
        
        
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        notiLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(notiLabel)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(notiLabel.snp.bottom).offset(12)
        }
        
        roundOfLottoLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
//        
//        stackView.snp.makeConstraints {
//            $0.top.equalTo(resultLabel.snp.bottom).offset(20)
//            $0.leading.equalToSuperview().inset(12)
//            $0.height.equalTo(ballSize)
//        }
//        
//        bnusLabel.snp.makeConstraints {
//            $0.top.equalTo(stackView.snp.bottom)
//            $0.centerX.equalTo(bnusNo.snp.centerX)
//        }
//        
//        
//        firstNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        secondNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        thirdNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        fourthNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        fifthNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        sixthNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        plusLabel.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        bnusNo.snp.makeConstraints {
//            $0.size.equalTo(ballSize)
//        }
//        
    }
    
    private func configView() {
        backgroundColor = .systemBackground
    }
}
