//
//  LottoCircle.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import UIKit

import SnapKit

final class LottoCircle: UIView {
    
    private let ballSize2 = ((UIScreen.main.bounds.width) - 4*7 - 12*2) / 8
    var lottoNo: Int = 0 {
        didSet {
            circle.backgroundColor = configCircleColor()
            numLabel.text = "\(lottoNo)"
        }
    }
    
    lazy var circle: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = ballSize2 / 2
        return view
    }()
    
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: ballSize2 / 2)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLayout() {
        [circle, numLabel].forEach { addSubview($0) }
        circle.snp.makeConstraints {
            $0.size.equalTo(ballSize2)
        }
        numLabel.snp.makeConstraints {
            $0.center.equalTo(circle)
        }
    }
    
    private func configCircleColor() -> UIColor {
        switch lottoNo {
        case 1...10:
            return .systemYellow
        case 11...20:
            return .systemTeal.withAlphaComponent(0.7)
        case 21...30:
            return .systemPink.withAlphaComponent(0.7)
        case 31...40:
            return .lightGray
        case 41...45:
            return .green.withAlphaComponent(0.5)
        default:
            print("번호 범위 벗어남")
            return .clear
        }
    }
}
