//
//  ViewController.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 09.06.2022.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Private variables
    
    private let dateFormatter = DateFormatter()
    private var userData: User?
    
    // MARK: - Privates Ui
    
    private lazy var btnEdit: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Редактировать", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnEdit_Click))
        return btn
    }()
    
    private lazy var tblData: UITableView = {
        let tbl = UITableView()
        tbl.register(InfoTblViewCell.self, forCellReuseIdentifier: InfoTblViewCell.indificatorCell)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.dataSource = self
        tbl.delegate = self
        tbl.allowsSelectionDuringEditing = false
        return tbl
    }()
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData = User.requestUserData()
        view.addSubview(tblData)
        configureUI()
    }
    
    // MARK: - Privates action
    
    @objc
    private func btnEdit_Click(_ sender: UIBarButtonItem) {
        let vc:EditViewController = EditViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Privates func
    
    private func configureUI() {
        self.navigationItem.rightBarButtonItem = btnEdit
        view.backgroundColor = .white
        title = "Просмотр"
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

// MARK: - UITableViewDataSource UITableViewDelegate

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTblViewCell.indificatorCell, for: indexPath) as? InfoTblViewCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
            case 0:
                cell.fill("Имя", userData?.name)
            case 1:
                cell.fill("Фамилия", userData?.surName)
            case 2:
                cell.fill("Отчество", userData?.middleName)
            case 3:
                if let dateOfBirth = userData?.dateOfBirth {
                    cell.fill("Дата рождения", dateFormatter.string(from: dateOfBirth))
                }else {
                    cell.fill("Дата рождения", "")
                }
            case 4:
                cell.fill("Пол", userData?.gender.description )
            default:
                break
        }
        return cell
    }
}

// MARK: - EditViewControllerDelegate

extension InfoViewController: EditViewControllerDelegate {
    
    internal func editViewControllerGetModel(_ editViewController: EditViewController) -> User {
        if let modelData = userData{
            return modelData
        }
        return User()
    }
    
    internal func editViewController (_ editViewController: EditViewController, didChanged data: User) {
        userData = data
        data.responseUserData(data)
        tblData.reloadData()
    }
    
    internal func editViewController(_ editViewController: EditViewController, willCompare data: User) -> Bool {
        if userData?.name == data.name{
            if userData?.surName == data.surName{
                if userData?.middleName == data.middleName{
                    if userData?.dateOfBirth == data.dateOfBirth{
                        if userData?.gender.description == data.gender.description{
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
}

