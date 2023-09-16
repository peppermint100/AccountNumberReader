import UIKit


class HistoryDetailsViewController: UIViewController {
    
    var history: History?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let formStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let titleFormView: HistoryDetailsFormView = {
        let view = HistoryDetailsFormView()
        view.historyDetailsType = .title
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentFormView: HistoryDetailsFormView = {
        let view = HistoryDetailsFormView()
        view.historyDetailsType = .content
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let createdAtFormView: HistoryDetailsFormView = {
        let view = HistoryDetailsFormView()
        view.historyDetailsType = .createdAt
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(titleFormView)
        formStackView.addArrangedSubview(contentFormView)
        formStackView.addArrangedSubview(createdAtFormView)
        applyConstraints()
        configureUI()
        configureDelegate()
        updateForms(history: history)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(view.safeAreaInsets)
    }
    
    private func applyConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ]
        
        let formStackViewConstraints = [
            formStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            formStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ]

        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(formStackViewConstraints)
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        if let history {
            imageView.image = history.image
        }
    }
    
    private func configureDelegate() {
        titleFormView.delegate = self
        contentFormView.delegate = self
        createdAtFormView.delegate = self
    }
    
    private func updateForms(history: History?) {
        if let history {
            titleFormView.configure(with:HistoryDetailsFormViewViewModel(title: "제목", value: history.title))
            contentFormView.configure(with:HistoryDetailsFormViewViewModel(title: "내용", value: history.content))
            createdAtFormView.configure(with:HistoryDetailsFormViewViewModel(title: "날짜", value: history.createdAt.toString()))
        }
    }
    
    private func toDetailVC() {
        let vc = HistoryDetailsEditViewController()
        vc.navigationItem.title = "123"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryDetailsViewController: HistoryDetailsFormViewDelegate, HistoryDetailsEditViewControllerDelegate {
    func didTapEditButton(historyDetailsType: HistoryDetailsType, value: String) {
        print("HistoryDetailsViewController didTapEditButton history = \(history)")
        print("value = ", value)
        if var history {
            switch historyDetailsType {
            case .title:
                history.title = value
                HistoryManager.shared.updateTitle(id: history.id, title: value)
            case .content:
                history.content = value
                HistoryManager.shared.updateContent(id: history.id, content: value)
            case .createdAt:
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.updateForms(history: history)
            }
        }
    }
    
    func moveToDetailsEditViewController(historyDetailsType: HistoryDetailsType) {
        print("HistoryDetailsViewController moveToDetailsEditViewController")
        let vc = HistoryDetailsEditViewController()
        vc.history = history
        vc.historyDetailsType = historyDetailsType
        vc.delegate = self
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = historyDetailsType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
}
