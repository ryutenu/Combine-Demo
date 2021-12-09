//
//  CustomCell.swift
//  Combine-Demo
//
//  Created by Alan Liu on 2021/12/09.
//

import UIKit
import Combine

class CustomCell: UITableViewCell {
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let buttonTapped = PassthroughSubject<String, Never>()
    
    private var company = ""
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.width-20, height: contentView.frame.height-5)
    }
    
    @objc private func actionButtonTapped() {
        buttonTapped.send("Cool! \(company) is great!")
    }
    
    func configureCell(_ company: String) {
        self.company = company
        button.setTitle(company, for: .normal)
    }
}
