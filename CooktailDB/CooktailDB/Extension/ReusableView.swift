import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
            return String(describing: self)
    }
    static var nibName: String {
            return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
