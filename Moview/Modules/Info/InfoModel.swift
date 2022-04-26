//
//  InfoModel.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 24/04/22.
//

import UIKit

struct InfoModel {

    struct Texts {
        static let keyFeedback = "Feedback:"
        static let keyName = "Develop by:"
        static let keyTest = "Test Condor Labs:"
        static let keyVersion = "Version:"
        static let title = "Information"
        static let valueFeedback = "alejobarbosalee@gmail.com"
        static let valueName = "Alejandro Barbosa"
        static let valueTest = "Mobile iOS Dev"
        static let valueVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}
