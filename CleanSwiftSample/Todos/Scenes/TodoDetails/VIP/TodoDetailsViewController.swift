import Foundation
import UIKit

final class TodoDetailsViewController: UIViewController {
    private let customView: TodoDetailsViewProtocol
    private let interactor: TodoDetailsInteractorProtocol

    init(sceneTitle: String, customView: TodoDetailsViewProtocol, interactor: TodoDetailsInteractorProtocol) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        title = sceneTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("🗑 Deallocating \(String(describing: self))")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDeleteButton()
        interactor.viewDidLoad()
    }

    private func setupDeleteButton() {
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                           target: self,
                                           action: #selector(didTouchDeleteButton))
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close,
                                          target: self,
                                          action: #selector(didTouchCloseButton))
        
        navigationItem.rightBarButtonItems = [closeButton, deleteButton]
    }

    @objc private func didTouchDeleteButton() {
        interactor.didTouchDeleteTodo()
    }

    @objc private func didTouchCloseButton() {
        interactor.didTouchCloseButton()
    }
}

extension TodoDetailsViewController: TodoDetailsPresenterDelegate {
    func render(viewModel: TodoDetailsViewModel.ViewModel) {
        customView.render(viewModel: viewModel)
    }
}
