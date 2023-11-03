//
//  SectionHeaderView.swift
//  CollapseSectionApp
//
//  Created by Grigory Sapogov on 03.11.2023.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    
    private let label: UILabel = UILabel()
    
    private let padding: CGFloat = 8
    
    private let leadingPadding: CGFloat = 16
    
    private var leadingConstraint: NSLayoutConstraint?
    
    private var paragraph: Paragraph?
    
    var action: ((Paragraph) -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setup()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
        self.layout()
    }
    
    private func setup() {
        self.contentView.backgroundColor = .gray.withAlphaComponent(0.3)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func layout() {
        self.contentView.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.leadingConstraint = self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leadingPadding)
        self.leadingConstraint?.isActive = true
        self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -padding).isActive = true
    }
    
    @objc
    private func actionTap(_ sender: Any) {
        guard let paragraph = self.paragraph else { return }
        self.action?(paragraph)
    }
    
    func setup(paragraph: Paragraph) {
        self.paragraph = paragraph
        self.label.text = paragraph.name
        self.leadingConstraint?.constant = CGFloat(paragraph.type) * self.leadingPadding
    }
    
}
