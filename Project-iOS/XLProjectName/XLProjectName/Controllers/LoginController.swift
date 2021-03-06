//
//  MainViewController.swift
//  XLProjectName
//
//  Created by XLAuthorName ( XLAuthorWebsite )
//  Copyright (c) 2016 XLOrganizationName. All rights reserved.
//

import Eureka
import RxSwift
import UIKit
import XLSwiftKit

internal class LoginController: FormViewController {

    fileprivate struct RowTags {
        static let LogInUsername: String = "log in username"
        static let LogInPassword: String = "log in password"
    }
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSections()
    }

    fileprivate func setUpSections() {
        form +++ Section(header: "Advanced usage", footer: "Please enter your credentials for advanced usage")
                <<< NameRow(RowTags.LogInUsername) {
                    $0.title = "Username:"
                    $0.placeholder = "insert username here.."
                }
                <<< PasswordRow(RowTags.LogInPassword) {
                    $0.title = "Password:"
                    $0.placeholder = "insert password here.."
                }
                <<< ButtonRow {
                    $0.title = "Log in"
                }
                .onCellSelection { [weak self] _, _ in
                    self?.loginTapped()
                }
    }
    
    fileprivate func getTextFromRow(_ tag: String) -> String? {
        let textRow: NameRow? = form.rowBy(tag: tag)
        let textEntered = textRow?.cell.textField.text
        return textEntered
    }
    
    fileprivate func getPasswordFromRow(_ tag: String) -> String? {
        let textRow: PasswordRow? = form.rowBy(tag: tag)
        let textEntered = textRow?.cell.textField.text
        return textEntered
    }
    
    // MARK: - Actions
    
    func loginTapped() {
        let writtenUsername = getTextFromRow(RowTags.LogInUsername)
        let writtenPassword = getPasswordFromRow(RowTags.LogInPassword)
        guard let username = writtenUsername, let password = writtenPassword, !username.isEmpty && !password.isEmpty else {
            showError("Please enter the username and password")
            return
        }

        self.showError("Great", message: "You have been successfully logged in")
    }
}
