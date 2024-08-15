//
//  NoteViewCell.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 20.07.2024.
//

import UIKit

class NoteViewCell: UITableViewCell {
    
     var Title = UILabel()
     var Note = UILabel()
    
    enum Identifier: String {
       case custom = "vb10"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        addSubview(Title)
        addSubview(Note)
        
        makeTitle()
        makeNote()
    }
}

extension NoteViewCell {
    private func makeTitle() {
        Title.font = .systemFont(ofSize: 17, weight: .bold)
        Title.textColor = UIColor(named: "noteTitle")
        Title.numberOfLines = 0
        
        
        Title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(5)
            make.top.equalToSuperview().offset(8)
            make.height.greaterThanOrEqualTo(25)
        }
    }
    
    private func makeNote() {
        Note.font = .systemFont(ofSize: 17)
        Note.textColor = UIColor(named: "noteColor")
        Note.numberOfLines = 0

        Note.snp.makeConstraints { make in
            make.top.equalTo(Title.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(10)
            make.height.greaterThanOrEqualTo(25)
            make.height.greaterThanOrEqualTo(25)

        }
    }
}
