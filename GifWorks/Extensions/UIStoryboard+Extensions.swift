//
//  UIStoryboard+Extensions.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import UIKit

extension UIStoryboard {
  static func instantiateViewController<T: UIViewController>(withType controller: T.Type) -> T? {
    return UIStoryboard(name: controller.identifier, bundle: nil).instantiateViewController(withIdentifier: controller.identifier) as? T
  }
}

