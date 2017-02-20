//
//  Common.swift
//  Pods
//
//  Created by Jan Čislinský on 17/02/2017.
//
//

import Foundation

extension NSAttributedString {

    func calculateHeight(in width: CGFloat) -> CGFloat {

        let boundingRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}
