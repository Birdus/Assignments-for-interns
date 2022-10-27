//
//  EditDateTblViewCell.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 15.06.2022.
//

import UIKit
protocol EditDateTblViewCellDelegate: AnyObject {
    func editDateTblViewCell(_ cell: EditDateTblViewCell, didChanged value: Date)
}
class EditDateTblViewCell: UITableViewCell {
    
    // MARK: - Public static variables
    
    static let indificatorCell: String = "EditDateTblViewCell"
    weak var delegete: EditDateTblViewCellDelegate!

    // MARK: - Privates Ui
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    private lazy var picDateTime: UIDatePicker = {
        let picDate = UIDatePicker()
        picDate.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.4, *) {
            picDate.preferredDatePickerStyle = .wheels
            }
        picDate.maximumDate = Date()
        picDate.datePickerMode = .date
        return picDate
    }()
    
    private lazy var txtDatePic: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.inputView = picDateTime
        var tlBarDatePic: UIToolbar = {
            let tlBar = UIToolbar()
            let doneButton = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnDone_Click))
            let cancelButton = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnCancel_click))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            tlBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
            tlBar.isUserInteractionEnabled = true
            tlBar.sizeToFit()
            return tlBar
        }()
        txt.inputAccessoryView = tlBarDatePic
        txt.textAlignment = .center
        txt.adjustsFontSizeToFitWidth = true
        txt.delegate = self
        return txt
    }()

    // MARK: - Application lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblInfo)
        contentView.addSubview(txtDatePic)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Privates action
    
    @objc
    private func btnDone_Click(_ sender: UIBarButtonItem) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        txtDatePic.text = dateFormater.string(from: picDateTime.date)
        delegete.editDateTblViewCell(self, didChanged: picDateTime.date)
        contentView.endEditing(true)
    }
    
    @objc
    private func btnCancel_click(_ sender: UIBarButtonItem) {
        contentView.endEditing(true)
    }
    
    // MARK: - Internal func
    
    internal func fill(_ lblText: String, _ value: String) {
        txtDatePic.text = value
        lblInfo.text = lblText
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
        
        let csRightTxtDatePic = NSLayoutConstraint(item: txtDatePic,
                                           attribute: NSLayoutConstraint.Attribute.right,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.right,
                                                  multiplier: 1.0,
                                                  constant: 35)
        
        let csCenterTxtDatePic = NSLayoutConstraint(item: txtDatePic,
                                           attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let csLeftTxtDatePic = NSLayoutConstraint(item: txtDatePic,
                                           attribute: NSLayoutConstraint.Attribute.left,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.left,
                                                  multiplier: 1.0,
                                                  constant: 220)
        
        self.addConstraints([csLeftLblInfo, csRightTxtDatePic, csCenterYLblInfo, csCenterTxtDatePic,csLeftTxtDatePic])
    }
}
extension EditDateTblViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            delegete.editDateTblViewCell(self, didChanged: picDateTime.date)
    }
}
    
