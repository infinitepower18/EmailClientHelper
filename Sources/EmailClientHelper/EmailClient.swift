//
//  EmailClient.swift
//
//
//  Created by Ahnaf Mahmud on 22/04/2024.
//

/// An enum of email clients supported by this package
public enum EmailClient: String, CaseIterable {
    
    /// The Gmail app
    case gmail = "googlegmail"
    
    /// The Microsoft Outlook app
    case outlook = "ms-outlook"
    
    /// The Yahoo Mail app
    case yahooMail = "ymail"
}
