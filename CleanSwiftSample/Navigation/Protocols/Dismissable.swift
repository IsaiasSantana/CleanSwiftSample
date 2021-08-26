protocol Dismissable: AnyObject {
    func dismiss(animated: Bool)

    func dismiss(animated: Bool, completion: (() -> Void)?)
}
