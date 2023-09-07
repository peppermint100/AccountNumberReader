
import UIKit

class HistoryDetailsEditViewController: UIViewController {
    
    var historyId: UUID?
    var value: String?
    var historyDetailsType: HistoryDetailsType?
    
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
        textField.text = value
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
    
    // 여기서 textField값을 올려야함
    @objc private func didTapEditButton() {
        let text = textField.text ?? ""
        print("text = \(text)")
        
        switch historyDetailsType {
        case .title:
            HistoryManager.shared.updateTitle(id: historyId ?? UUID(), title: text)
        case .content:
            HistoryManager.shared.updateContent(id: historyId ?? UUID(), content: text)
        default:
            return
        }
        
        // popViewController를 하고 HistoryDetailsViewController의 데이터를 리로드 해줘야 한다.
        navigationController?.popViewController(animated: true)
    }
}
