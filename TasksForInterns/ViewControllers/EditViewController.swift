//
//  EditViewController.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 14.06.2022.
//

import UIKit

protocol EditViewControllerDelegate : AnyObject {
    func editViewController (_ editViewController: EditViewController, didChanged data: User)
    func editViewControllerGetModel (_ editViewController: EditViewController) -> User
    func editViewController (_ editViewController: EditViewController, willCompare data: User) -> Bool
}

class EditViewController: UIViewController {
    // MARK: - Public variables
    weak var delegate: EditViewControllerDelegate!
    
    // MARK: - Private variables
    
    private var userData: User!
    private let dateFormatter = DateFormatter()
    
    // MARK: - Privates Ui
    
    private lazy var btnSave: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnSave_Click))
        return btn
    }()
    
    private lazy var btnBack: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBack_Click))
        return btn
    }()
    
    private lazy var tblData: UITableView = {
        let tbl = UITableView()
        tbl.register(EditTextTblViewCell.self, forCellReuseIdentifier: EditTextTblViewCell.indificatorCell)
        tbl.register(EditDateTblViewCell.self, forCellReuseIdentifier: EditDateTblViewCell.indificatorCell)
        tbl.register(EditGenderTblViewCell.self, forCellReuseIdentifier: EditGenderTblViewCell.indificatorCell)
        tbl.dataSource = self
        tbl.delegate = self
        tbl.allowsSelectionDuringEditing = false
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData = delegate?.editViewControllerGetModel(self)
        view.addSubview(tblData)
        configureUI()
    }
    
    // MARK: - Privates action
    @objc
    private func btnBack_Click(_ sender: UIBarButtonItem) {
        if delegate.editViewController (self, willCompare: userData) {
                createWarningSaveDataAlert()
            }else {
                self.navigationController?.popViewController(animated: true)
            }
    }
    
    @objc
    private func btnSave_Click(_ sender: UIBarButtonItem) {
        showSaveDataAlert(txtChange: {
                        createErrorSaveDataAlert()
                  }, txtNotChange:{
                      delegate?.editViewController(self, didChanged: userData)
                        navigationController?.popViewController(animated: true)
                        dismiss(animated: true, completion: nil)
                  })
    }
    
    // MARK: - Privates func
    
    private func createErrorSaveDataAlert() {
        let alControl:UIAlertController = {
            let alControl = UIAlertController(title: "Ошибка", message: "Все поля, за исключением отчества являются обязательными.", preferredStyle: .alert)
            
            let btnOk: UIAlertAction = {
                let btn = UIAlertAction(title: "Ок", style: .default, handler: {(alert: UIAlertAction!) in
                    self.dismiss(animated: true, completion: nil)
                })
                return btn
            }()
            
            alControl.addAction(btnOk)
            return alControl
        }()
        present(alControl, animated: true, completion: nil)
    }
    
    private func createWarningSaveDataAlert() {
        let alControl:UIAlertController = {
            let alControl = UIAlertController(title: "Внимание", message: "Вы изменили данные хотите сохранить?", preferredStyle: .actionSheet)
            
            let btnDoneSave: UIAlertAction = {
                
            let btn = UIAlertAction(title: "Сохранить", style: .default, handler: {(alert: UIAlertAction!) in
                    self.showSaveDataAlert(txtChange:{
                        self.createErrorSaveDataAlert()
                        }, txtNotChange:{
                            self.delegate.editViewController(self, didChanged: self.userData)
                                  self.navigationController?.popViewController(animated: true)
                                  self.dismiss(animated: true, completion: nil)
                              })
                })
                return btn
            }()
            
            let btnCancelSave: UIAlertAction = {
                let btn = UIAlertAction(title: "Пропустить", style: .default, handler: {(alert: UIAlertAction!) in
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                })
                return btn
            }()
            
            alControl.addAction(btnDoneSave)
            alControl.addAction(btnCancelSave)
            return alControl
        }()
        present(alControl, animated: true, completion: nil)
    }
    
    private func showSaveDataAlert(txtChange completion: () -> Void, txtNotChange onFailure: () -> Void) {
        if userData.name.isNullOrWhiteSpace || userData.surName.isNullOrWhiteSpace {
            completion()
        }else {
            onFailure()
        }
    }
    
    private func configureUI() {
        self.navigationItem.rightBarButtonItem = btnSave
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = btnBack
        title = "Редактирования"
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let csTopTblView = NSLayoutConstraint(item: tblData,
                                           attribute: NSLayoutConstraint.Attribute.top,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: NSLayoutConstraint.Attribute.top,
                                                  multiplier: 1.0,
                                                  constant: 10)
        
        let csBotTblView = NSLayoutConstraint(item: tblData,
                                           attribute: NSLayoutConstraint.Attribute.bottom,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: NSLayoutConstraint.Attribute.bottom,
                                                  multiplier: 1.0,
                                                  constant: 10)
        
        let csLeftTblView = NSLayoutConstraint(item: tblData,
                                           attribute: NSLayoutConstraint.Attribute.left,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: NSLayoutConstraint.Attribute.left,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let csRightTblView = NSLayoutConstraint(item: tblData,
                                           attribute: NSLayoutConstraint.Attribute.right,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: NSLayoutConstraint.Attribute.right,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        
        self.view.addConstraints([csTopTblView,csBotTblView,csLeftTblView,csRightTblView])
    }
}

// MARK: - extension EditVC: UITableViewDataSource, UITableViewDelegate

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 3) {
            guard let cellEditDate = tableView.dequeueReusableCell(withIdentifier: EditDateTblViewCell.indificatorCell, for: indexPath) as? EditDateTblViewCell else {
                return UITableViewCell()
            }
            cellEditDate.fill("Дата рождения",  dateFormatter.string(from: userData.dateOfBirth))
            cellEditDate.delegete = self
            return cellEditDate
            
        }else if (indexPath.row == 4) {
            guard let cellEditGender = tableView.dequeueReusableCell(withIdentifier: EditGenderTblViewCell.indificatorCell, for: indexPath) as? EditGenderTblViewCell else {
                return UITableViewCell()
            }
            
            cellEditGender.fill("Пол", userData.gender.description)
            cellEditGender.delegete = self
            return cellEditGender
            
        }
        
        guard let cellEditText = tableView.dequeueReusableCell(withIdentifier: EditTextTblViewCell.indificatorCell, for: indexPath) as? EditTextTblViewCell else {
                return UITableViewCell()
        }
        
        switch indexPath.row {
            case 0:
                cellEditText.fill("Имя", userData.name)
            case 1:
                cellEditText.fill("Фамилия", userData.surName)
            case 2:
                cellEditText.fill("Отчество", userData.middleName ?? "")
            default:
                break
        }
        cellEditText.delegete = self
        return cellEditText
    }
}

// MARK: - EditTextTblViewCellDelegate

extension EditViewController: EditTextTblViewCellDelegate {
    internal func editTextTblViewCell(_ cell: EditTextTblViewCell, didChanged value: String) {
        let cellThatChanged = tblData.indexPath(for: cell)!.row
        switch cellThatChanged {
        case 0:
            userData.name = value
        case 1:
            userData.surName = value
        case 2:
            userData.middleName = value
        default:
            print("Error")
        }
    }
}

// MARK: - EditDateTblViewCellDelegate

extension EditViewController: EditDateTblViewCellDelegate {
    internal func editDateTblViewCell(_ cell: EditDateTblViewCell, didChanged value: Date) {
        userData.dateOfBirth = value
    }
}

// MARK: - EditGenderTblViewCellDelegate

extension EditViewController: EditGenderTblViewCellDelegate {
    internal func editGenderTblViewCell(_ cell: EditGenderTblViewCell, didChanged value: Gender) {
        userData.gender = value
    }
}

// MARK: - extension String

extension String {
  var isNullOrWhiteSpace: Bool {
    return allSatisfy({ $0.isWhitespace })
  }
}

