import Foundation
import UIKit

protocol TodoDetailsViewProtocol where Self: UIView {
    func render(viewModel: TodoDetailsViewModel.ViewModel)
}

final class TodoDetailsView: UIView, TodoDetailsViewProtocol {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    private let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 8
        stackview.axis = .vertical
        return stackview
    }()

    private let todoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let todoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupContainerView()
    }

    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setupContentStackView()
    }

    private func setupContentStackView() {
        containerView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        setupTodoNameLabel()
        setupTodoDescriptionLabel()
    }

    private func setupTodoNameLabel() {
        contentStackView.addArrangedSubview(todoNameLabel)
    }

    private func setupTodoDescriptionLabel() {
        contentStackView.addArrangedSubview(todoDescriptionLabel)
    }

    func render(viewModel: TodoDetailsViewModel.ViewModel) {
        todoNameLabel.text = viewModel.todoName
        todoDescriptionLabel.text = viewModel.todoDescription
    }
}
