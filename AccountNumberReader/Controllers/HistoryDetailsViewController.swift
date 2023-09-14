import UIKit


class HistoryDetailsViewController: UIViewController {
    
    var history: History?
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.backgroundColor = .systemGreen
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
//    private let detailsFormView: HistoryDetailsFormView = {
//        let view = HistoryDetailsFormView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .green
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
        view.backgroundColor = .systemCyan
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
//        stackView.addArrangedSubview(detailsFormView)
        applyConstraints()
        configureUI()
        configureForms()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
//        let imageViewConstraints = [
//            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
//        ]
//        let detailsFormViewConstraints = [
//            detailsFormView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
//        ]

        NSLayoutConstraint.activate(stackViewConstraints)
//        NSLayoutConstraint.activate(imageViewConstraints)
//        NSLayoutConstraint.activate(detailsFormViewConstraints)
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
//        detailsFormView.configure(with:
//            HistoryDetailsFormViewViewModel(title: "제목", value: "값")
//        )
    }
    
    private func toDetailVC() {
        let vc = HistoryDetailsEditViewController()
        vc.navigationItem.title = "123"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationController?.pushViewController(vc, animated: true)
    }
}
