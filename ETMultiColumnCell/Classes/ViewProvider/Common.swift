//
//  Common.swift
//  Pods
//
//  Created by Jan Čislinský on 17/02/2017.
//
//

import Foundation

extension NSAttributedString {

    func calculateHeight(inWidth width: CGFloat, isMultiline: Bool) -> CGFloat {

        let widthConstraints = (isMultiline == true ? width : CGFloat.greatestFiniteMagnitude)
        let boundingRect = self.boundingRect(with: CGSize(width: widthConstraints, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}
