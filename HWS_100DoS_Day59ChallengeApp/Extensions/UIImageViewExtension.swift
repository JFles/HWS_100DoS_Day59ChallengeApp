//
//  UIImageViewExtension.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/25/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    print("Failed to create image from Data object")
                }
            } else {
                print("Failed to load remote image from url")
            }
        }
    }
}
