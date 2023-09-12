
import UIKit

protocol HistoryDetailsEditViewControllerDelegate: AnyObject {
    func didTapEditButton(newHistory: History?, type: HistoryDetailsType?)
}

class HistoryDetailsEditViewController: UIViewController {
    
    var historyDetailsType: HistoryDetailsType?
    var history: History?
    
    var delegate: HistoryDetailsEditViewControllerDelegate?
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.textAlignment = .center
        tf.backgroundColor = .systemGray5
        tf.autocorrectionType = .no
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
//        textField.text = value
        if (historyDetailsType == .title) {
            textField.text = history?.title
        } else {
            textField.text = history?.content
        }
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        applyConstraints()
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
        print("text = \(text)")
        
        switch historyDetailsType {
        case .title:
            history?.title = text
        case .content:
            history?.content = text
        case .createdAt:
            return
        default :
            return
        }
        
        delegate?.didTapEditButton(newHistory: history, type: historyDetailsType)

        navigationController?.popViewController(animated: true)
    }
}
