//
//  EditTblViewCell.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 14.06.2022.
//

import UIKit

protocol EditTextTblViewCellDelegate: AnyObject {
    func editTextTblViewCell(_ cell: EditTextTblViewCell, didChanged value: String)
}

class EditTextTblViewCell: UITableViewCell {
    
    // MARK: - Public static variables
    
    static let indificatorCell: String = "EditTextTblViewCell"
    weak var delegete: EditTextTblViewCellDelegate!
    
    // MARK: - Private variables
    
    private var valuesTxtFldBeforeEditing: String!

    // MARK: - Privates Ui
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        return lbl
    }()

    private lazy var txtFld: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        var tlBarTxt: UIToolbar = {
            let tlBar = UIToolbar()
            let btnDone = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnDone_Click))
            let btnCancel = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnCancel_click))
            let btnSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            tlBar.setItems([btnCancel, btnSpace, btnDone], animated: true)
            tlBar.isUserInteractionEnabled = true
            tlBar.sizeToFit()
            return tlBar
        }()
        txt.inputAccessoryView = tlBarTxt
        txt.textAlignment = .right
        txt.delegate = self
        txt.adjustsFontSizeToFitWidth = true
        return txt
    }()
    
    // MARK: - Application lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblInfo)
        contentView.addSubview(txtFld)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates action
    
    @objc
    private func btnDone_Click(_ sender: UIBarButtonItem) {
        valuesTxtFldBeforeEditing = txtFld.text
        delegete.editTextTblViewCell(self, didChanged: txtFld.text!)
        contentView.endEditing(true)
    }
    
    @objc
    private func btnCancel_click(_ sender: UIBarButtonItem) {
        txtFld.text = valuesTxtFldBeforeEditing
        contentView.endEditing(true)
    }
    
    // MARK: - Internal func
    
    internal func fill(_ lblText: String, _ value: String) {
        lblInfo.text = lblText
        txtFld.text = value
    }
    
    // MARK: - Privates func
    
    private func configureUI() {
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
        
        let csRightTxtFld = NSLayoutConstraint(item: txtFld,
                                           attribute: NSLayoutConstraint.Attribute.right,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.right,
                                                  multiplier: 1.0,
                                                  constant: -20)
        
        let csLeftTxtFld = NSLayoutConstraint(item: txtFld,
                                           attribute: NSLayoutConstraint.Attribute.left,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.left,
                                                  multiplier: 1.0,
                                                  constant: 200)
        
        let csCenterTxtFld = NSLayoutConstraint(item: txtFld,
                                           attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        self.addConstraints([csLeftLblInfo, csRightTxtFld, csCenterYLblInfo, csCenterTxtFld, csLeftTxtFld])
    }

}

// MARK: - UITextFieldDelegate

extension EditTextTblViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegete.editTextTblViewCell(self, didChanged: textField.text!)
    }
}
    
