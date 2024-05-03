//
//  EmailClientHelper.swift
//
//
//  Created by Ahnaf Mahmud on 22/04/2024.
//

import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

/// Helper class to send an email using 3rd party apps
public class EmailClientHelper {

    /// An array of available email clients on the device
    public static var availableClients: [EmailClient] {
        var clients: [EmailClient] = []
        
        #if os(iOS) || os(visionOS) || targetEnvironment(macCatalyst) || os(macOS)
        for client in EmailClient.allCases {
            if isClientAvailable(client) {
                clients.append(client)
            }
        }
        #endif
        
        return clients
    }
    
    /// Checks whether a specific client is available on the device
    /// - Parameter client: The email client to check
    /// - Returns: Whether the client is available
    public static func isClientAvailable(_ client: EmailClient) -> Bool {
        #if os(iOS) || os(visionOS) || targetEnvironment(macCatalyst)
        let urlProtocol = URL(string: "\(client.rawValue)://")
        
        if let urlProtocol = urlProtocol, UIApplication.shared.canOpenURL(urlProtocol) {
            return true
        } else {
            return false
        }
        #elseif os(macOS)
        let bundleId = getBundleId(of: client, isNativeMac: true)
        if NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) != nil {
            return true
        } else {
            return false
        }
        #else
        return false
        #endif
    }
    
    /// Get the email URL
    /// - Parameters:
    ///   - client: The email client
    ///   - to: The email address to send to
    ///   - subject: The email subject
    ///   - body: The email body
    public static func getEmailURL(client: EmailClient, to: String, subject: String = "", body: String = "") -> URL? {
        var url: URL?
        
        #if os(iOS) || os(visionOS) || targetEnvironment(macCatalyst) || os(macOS)
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        guard let encodedBody = encodedBody, let encodedSubject = encodedSubject else {
            return nil
        }
        
        switch client {
            case .gmail:
                url = URL(string: "googlegmail://co?to=\(to)&subject=\(encodedSubject)&body=\(encodedBody)")
            case .outlook:
                url = URL(string: "ms-outlook://compose?to=\(to)&subject=\(encodedSubject)&body=\(encodedBody)")
            case .yahooMail:
                url = URL(string: "ymail://mail/compose?to=\(to)&subject=\(encodedSubject)&body=\(encodedBody)")
        }
        #endif
        
        return url
    }
    
    /// Send an email using the specified email client
    /// - Parameters:
    ///   - client: The email client to use
    ///   - to: The email address to send to
    ///   - subject: The email subject
    ///   - body: The email body
    public static func sendEmail(client: EmailClient, to: String, subject: String = "", body: String = "") {
        #if os(iOS) || os(visionOS) || targetEnvironment(macCatalyst) || os(macOS)
        let url: URL? = getEmailURL(client: client, to: to, subject: subject, body: body)
        
        if let url {
            #if os(macOS)
            NSWorkspace.shared.open(url)
            #else
            UIApplication.shared.open(url)
            #endif
        }
        #endif
    }

    /// Get the bundle ID of the specified client
    /// - Parameters:
    ///   - client: The email client
    ///   - isNativeMac: Whether the package is being used on a native macOS app
    /// - Returns: The bundle ID of the specified client
    public static func getBundleId(of client: EmailClient, isNativeMac: Bool) -> String {
        switch client {
        case .gmail:
            return "com.google.Gmail" // iOS version only
        case .outlook:
            if isNativeMac {
                return "com.microsoft.Outlook"
            } else {
                return "com.microsoft.Office.Outlook"
            }
        case .yahooMail:
            return "com.yahoo.Aerogram" // iOS version only
        }
    }
}
