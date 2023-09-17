
import UIKit

protocol HistoryDetailsEditViewControllerDelegate {
    func didTapEditButton(historyDetailsType: HistoryDetailsType, value: String)
}

class HistoryDetailsEditViewController: UIViewController {
    
    var delegate: HistoryDetailsEditViewControllerDelegate?
    
    var history: History?
    var historyDetailsType: HistoryDetailsType?
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.textAlignment = .center
        tf.backgroundColor = .systemGray5
        tf.autocorrectionType = .no
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("수정", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(textField)
        view.addSubview(editButton)
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        applyConstraints()
        configureTextField()
    }
    
    private func configureTextField() {
        if let history {
            switch historyDetailsType {
            case .title:
                textField.text = history.title
            case .content:
                textField.text = history.content
            case .createdAt:
                textField.text = history.createdAt.toString()
            default:
                return
            }
        }
    }
    
    private func applyConstraints() {
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        let confirmButtonConstraints = [
            editButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(confirmButtonConstraints)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func didTapEditButton() {
        print("HistoryDetailsEditViewController didTapEditButton")
        let text = textField.text ?? ""
        if let historyDetailsType {
            delegate?.didTapEditButton(historyDetailsType: historyDetailsType, value: text)
            navigationController?.popViewController(animated: true)
        }
    }
}
