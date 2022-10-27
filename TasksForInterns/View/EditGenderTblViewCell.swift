//
//  EditGenderTblViewCell.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 15.06.2022.
//

import UIKit

protocol EditGenderTblViewCellDelegate: AnyObject {
    func editGenderTblViewCell(_ cell: EditGenderTblViewCell, didChanged value: Gender)
}

class EditGenderTblViewCell: UITableViewCell {

    // MARK: - Public static variables
    
    static let indificatorCell: String = "EditGenderTblViewCell"
    weak var delegete: EditGenderTblViewCellDelegate!
    
    // MARK: - Privates Ui
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    private lazy var picGender: UIPickerView = {
        let picDate = UIPickerView()
        picDate.translatesAutoresizingMaskIntoConstraints = false
        picDate.delegate = self
        picDate.dataSource = self
        return picDate
    }()

    private lazy var txtGenderPic: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.inputView = picGender
        let tlBarGenderPic: UIToolbar = {
            let tlBar = UIToolbar()
            let doneButton = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnDone_Click))
            let cancelButton = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnCancel_click))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            tlBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
            tlBar.isUserInteractionEnabled = true
            tlBar.sizeToFit()
            return tlBar
        }()
        txt.inputAccessoryView = tlBarGenderPic
        txt.textAlignment = .center
        txt.delegate = self
        txt.adjustsFontSizeToFitWidth = true
        return txt
    }()

    // MARK: - Application lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblInfo)
        contentView.addSubview(txtGenderPic)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Privates action
    
    @objc
    private func btnDone_Click(_ sender: UIBarButtonItem) {
        let selectedGender: Gender =  Gender.allCases[picGender.selectedRow(inComponent: 0)]
        txtGenderPic.text = selectedGender.description
        delegete.editGenderTblViewCell(self, didChanged: selectedGender)
        contentView.endEditing(true)
    }
    
    @objc
    private func btnCancel_click(_ sender: UIBarButtonItem) {
        contentView.endEditing(true)
    }
    
    // MARK: - Internal func
    
    internal func fill(_ lblText: String, _ value: String) {
        txtGenderPic.text = value
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
        
        let csRightTxtDatePic = NSLayoutConstraint(item: txtGenderPic,
                                           attribute: NSLayoutConstraint.Attribute.right,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.right,
                                                  multiplier: 1.0,
                                                  constant: 40)
        
        let csCenterTxtDatePic = NSLayoutConstraint(item: txtGenderPic,
                                           attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let csLeftTxtGenderPic = NSLayoutConstraint(item: txtGenderPic,
                                           attribute: NSLayoutConstraint.Attribute.left,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.left,
                                                  multiplier: 1.0,
                                                  constant: 220)
        
        self.addConstraints([csLeftLblInfo, csRightTxtDatePic, csCenterYLblInfo, csCenterTxtDatePic,csLeftTxtGenderPic])
    }
}

// MARK: - extension EditGenderTblViewCell

extension EditGenderTblViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender.allCases[row].description
    }
}

extension EditGenderTblViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let selectedGender: Gender =  Gender.allCases[picGender.selectedRow(inComponent: 0)]
        delegete.editGenderTblViewCell(self, didChanged: selectedGender)
    }
}
