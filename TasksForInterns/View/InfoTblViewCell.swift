//
//  CustomTableMainViewCell.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 14.06.2022.
//

import UIKit

class InfoTblViewCell: UITableViewCell {
    // MARK: - Public static variables
    
    static let indificatorCell: String = "InfoTblViewCell"
    
    // MARK: - Private static variables
    
    private let dateFormatter = DateFormatter()
    
    // MARK: - Privates Ui
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var lblData: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: - Application lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblInfo)
        contentView.addSubview(lblData)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    internal func fill(_ lblText: String, _ value: String?) {
        lblInfo.text = lblText
        lblData.text = value
    }
    
    // MARK: - Privates func
    private func configureUI(){
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let csLeftLblInfo = NSLayoutConstraint(item: lblInfo,
                                               attribute: NSLayoutConstraint.Attribute.left,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.left,
                                               multiplier: 1.0,
                                               constant: 20)
        
        let csCenterYLblInfo = NSLayoutConstraint(item: lblInfo,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let csRightLblData = NSLayoutConstraint(item: lblData,
                                                attribute: NSLayoutConstraint.Attribute.right,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: NSLayoutConstraint.Attribute.right,
                                                multiplier: 1.0,
                                                constant: -20)
        
        let csCenterLblData = NSLayoutConstraint(item: lblData,
                                                 attribute: NSLayoutConstraint.Attribute.centerY,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: NSLayoutConstraint.Attribute.centerY,
                                                 multiplier: 1.0,
                                                 constant: 0)
        
        let csLeftLblData = NSLayoutConstraint(item: lblData,
                                               attribute: NSLayoutConstraint.Attribute.left,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.left,
                                               multiplier: 1.0,
                                               constant: 200)
        
        self.addConstraints([csLeftLblInfo, csRightLblData, csCenterYLblInfo, csCenterLblData, csLeftLblData])
    }
}
