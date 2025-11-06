import UIKit
import NukeExtensions

class DetailViewController: UIViewController {

    var post: Post?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let postImageView = UIImageView()
    private let summaryLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Post Detail"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupUI()
        configureData()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        contentView.addSubview(postImageView)
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(summaryLabel)
        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: 16)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            postImageView.heightAnchor.constraint(equalToConstant: 300),

            summaryLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func configureData() {
        guard let post = post else { return }
        summaryLabel.text = String(post.summary).trimHTMLTags() ?? post.summary
        if let photo = post.photos.first {
            NukeExtensions.loadImage(with: photo.originalSize.url, into: postImageView)
        }
    }
}
