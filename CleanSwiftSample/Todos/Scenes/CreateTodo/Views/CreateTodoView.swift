import Foundation
import UIKit

protocol CreateTodoViewProtocol where Self: UIView {
    func setup(delegate: CreateTodoViewDelegate)
}

protocol CreateTodoViewDelegate: AnyObject {
    func createTodo(name: String?, description: String?)
}

final class CreateTodoView: UIView, CreateTodoViewProtocol {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    private let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 16
        return stackview
    }()

    private let nameTodoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CreateTodoStrings.todoName
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let nameTodoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = CreateTodoStrings.todoPlaceholder
        textField.keyboardType = .default
        return textField
    }()

    private let descriptionTodoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CreateTodoStrings.todoDescription
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let descriptionTodoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = CreateTodoStrings.descriptionPlaceholder
        textField.keyboardType = .default
        return textField
    }()

    private let createTodoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(CreateTodoStrings.createTodo, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()

    private weak var delegate: CreateTodoViewDelegate?

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
        backgroundColor = .white
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
        setupCreateTodoButton()
        setupGesture()
    }

    private func setupContentStackView() {
        containerView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        setupNameTodoLabel()
        setupNameTodoTextField()
        setupDescriptionTodoLabel()
        setupDescriptionTodoTextField()
    }

    private func setupNameTodoLabel() {
        contentStackView.addArrangedSubview(nameTodoLabel)
    }

    private func setupNameTodoTextField() {
        contentStackView.addArrangedSubview(nameTodoTextField)
    }

    private func setupDescriptionTodoLabel() {
        contentStackView.addArrangedSubview(descriptionTodoLabel)
    }

    private func setupDescriptionTodoTextField() {
        contentStackView.addArrangedSubview(descriptionTodoTextField)
    }

    func setupCreateTodoButton() {
        containerView.addSubview(createTodoButton)
        NSLayoutConstraint.activate([
            createTodoButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 16),
            createTodoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            createTodoButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        createTodoButton.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
    }

    @objc private func didTouchButton() {
        closeKeyboard()
        delegate?.createTodo(name: nameTodoTextField.text,
                             description: descriptionTodoTextField.text)
    }

    private func closeKeyboard() {
        containerView.endEditing(true)
    }

    private func setupGesture() {
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGesture)))
    }

    @objc private func didTapGesture() {
        closeKeyboard()
    }

    func setup(delegate: CreateTodoViewDelegate) {
        self.delegate = delegate
    }
}
