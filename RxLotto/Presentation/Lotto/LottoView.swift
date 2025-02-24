//
//  LottoView.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import UIKit

import SnapKit

final class LottoView: UIView {
    
    private let ballSize2 = ((UIScreen.main.bounds.width) - 4*7 - 12*2) / 8
    
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
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    private let bnusLabel: UILabel = {
        let label = UILabel()
        label.text = "보너스"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let test: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 10
        return view
    }()
    
    private let firstNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 1
        return view
    }()
    private let secondNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 10
        return view
    }()
    private let thirdNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 20
        return view
    }()
    private let fourthNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 30
        return view
    }()
    private let fifthNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 40
        return view
    }()
    private let sixthNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 20
        return view
    }()
    private let bnusNo: LottoCircle = {
        let view = LottoCircle()
        view.lottoNo = 20
        return view
    }()
    private let plusLabel: LottoCircle = {
        let view = LottoCircle()
        view.circle.backgroundColor = .clear
        view.numLabel.text = "+"
        view.numLabel.textColor = .label
        return view
    }()
    let observableButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.title = "Observable"
        button.configuration?.baseForegroundColor = .label
        button.configuration?.background.backgroundColor = .secondarySystemBackground
        return button
    }()
    let singleButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.title = "Single"
        button.configuration?.baseForegroundColor = .label
        button.configuration?.background.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LottoView {
    private func configLayout() {
        [textField, notiLabel, dateLabel, dividerView, roundOfLottoLabel, stackView, bnusLabel, observableButton, singleButton].forEach { addSubview($0) }
        
        [firstNo, secondNo, thirdNo, fourthNo, fifthNo, sixthNo, plusLabel, bnusNo].forEach { stackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.size.equalTo(ballSize2)
            }
        }
        
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
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(roundOfLottoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(12)
            $0.height.equalTo(ballSize2)
        }
        
        bnusLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.centerX.equalTo(bnusNo.snp.centerX)
        }
        
        observableButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().multipliedBy(0.5)
        }
        singleButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().multipliedBy(1.5)
        }
    }
    
    func configView(lotto: Lotto) {
        DispatchQueue.main.async {
            self.textField.text = "\(lotto.drwNo)"
            self.dateLabel.text = lotto.drwNoDate
            self.roundOfLottoLabel.text = "\(lotto.drwNo)회 당첨결과"
            self.firstNo.lottoNo = lotto.drwtNo1
            self.secondNo.lottoNo = lotto.drwtNo2
            self.thirdNo.lottoNo = lotto.drwtNo3
            self.fourthNo.lottoNo = lotto.drwtNo4
            self.fifthNo.lottoNo = lotto.drwtNo5
            self.sixthNo.lottoNo = lotto.drwtNo6
            self.bnusNo.lottoNo = lotto.bnusNo
        }
    }
}
