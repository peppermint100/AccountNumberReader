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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentFormView: HistoryDetailsFormView = {
        let view = HistoryDetailsFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let createdAtFormView: HistoryDetailsFormView = {
        let view = HistoryDetailsFormView()
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
        configureForms()
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
    
    private func configureForms() {
        titleFormView.configure(with:HistoryDetailsFormViewViewModel(title: "제목", value: "값"))
        contentFormView.configure(with:HistoryDetailsFormViewViewModel(title: "내용", value: "01-123-134124 국민"))
        createdAtFormView.configure(with:HistoryDetailsFormViewViewModel(title: "날짜", value: "2023-09-13"))
    }
    
    private func toDetailVC() {
        let vc = HistoryDetailsEditViewController()
        vc.navigationItem.title = "123"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationController?.pushViewController(vc, animated: true)
    }
}
