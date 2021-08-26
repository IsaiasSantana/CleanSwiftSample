import Foundation
import UIKit

protocol TodoCellDelegate: AnyObject {
    func didTouchCheckBox(todoId: String)
}

final class TodoCell: UITableViewCell, TodoCellViewDelegate {
    private let todoCellView = TodoCellView()
    private var viewModel: TodoHomeViewModel.ViewModel?

    weak var delegate: TodoCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        selectionStyle = .none
        setupTodoCellView()
        setupDelegate()
    }

    private func setupTodoCellView() {
        contentView.addSubview(todoCellView)
        NSLayoutConstraint.activate([
            todoCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            todoCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            todoCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            todoCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func setupDelegate() {
        todoCellView.delegate = self
    }

    func render(viewModel: TodoHomeViewModel.ViewModel) {
        self.viewModel = viewModel
        todoCellView.render(viewModel: viewModel)
    }

    func didTouchCheckBox() {
        guard let viewModel = viewModel else {
            return
        }
        delegate?.didTouchCheckBox(todoId: viewModel.id)
    }
}


private protocol TodoCellViewDelegate: AnyObject {
    func didTouchCheckBox()
}

private final class TodoCellView: UIView {
    private let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.spacing = 16
        return stackview
    }()

    private let labelsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 16
        return stackview
    }()

    private let todoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()

    private let todoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()

    private let checkBoxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let checkBoxButton = CheckBoxButton()

    weak var delegate: TodoCellViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupContentStackView()
    }

    private func setupContentStackView() {
        addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setupLabelsStackView()
        setupCheckBoxView()
    }

    private func setupLabelsStackView() {
        contentStackView.addArrangedSubview(labelsStackView)
        setupTodoNameLabel()
        setupTodoDescriptionLabel()
    }

    private func setupTodoNameLabel() {
        labelsStackView.addArrangedSubview(todoNameLabel)
    }

    private func setupTodoDescriptionLabel() {
        labelsStackView.addArrangedSubview(todoDescriptionLabel)
    }

    private func setupCheckBoxView() {
        contentStackView.addArrangedSubview(checkBoxView)
        setupCheckBoxButton()
    }

    private func setupCheckBoxButton() {
        checkBoxView.addSubview(checkBoxButton)
        NSLayoutConstraint.activate([
            checkBoxButton.topAnchor.constraint(equalTo: checkBoxView.topAnchor),
            checkBoxButton.trailingAnchor.constraint(equalTo: checkBoxView.trailingAnchor),
            checkBoxButton.leadingAnchor.constraint(equalTo: checkBoxView.leadingAnchor)
        ])
        setupCheckBoxTouch()
    }

    private func setupCheckBoxTouch() {
        checkBoxButton.addTarget(self, action: #selector(didTouchCheckBox), for: .touchUpInside)
    }

    @objc private func didTouchCheckBox() {
        delegate?.didTouchCheckBox()
    }

    func render(viewModel: TodoHomeViewModel.ViewModel) {
        todoNameLabel.text = viewModel.todoName
        todoDescriptionLabel.text = viewModel.todoDescription
        checkBoxButton.isChecked = viewModel.completed
    }
}
