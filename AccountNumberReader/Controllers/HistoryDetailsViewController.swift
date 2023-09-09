import UIKit

class HistoryDetailsViewController: UIViewController {
    
    var history: History?
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let contentTextLabel: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(contentTextLabel)
        stackView.addArrangedSubview(createdAtLabel)
        configureUI()
        applyConstraints()
    }
    
    private func configureUI() {
        imageView.image = history?.image
        titleTextField.text = history?.title
        contentTextLabel.text = history?.content
        createdAtLabel.text = history?.createdAt.toString()
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let imageViewConstraints = [
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ]
        let titleLabelConstraints = [
            titleTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ]
        let contentLabelConstraints = [
            contentTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ]
        let createdAtLabelConstraints = [
            createdAtLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(contentLabelConstraints)
        NSLayoutConstraint.activate(createdAtLabelConstraints)
    }
}
